//
//  ContentView.swift
//  Word Match
//
//  Created by Evgeniy on 01.05.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    @State private var isSettingsActive = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.yellow
                .opacity(0.3)
                .ignoresSafeArea()
            VStack {
                Spacer(minLength: topSpace)
                Header(revealAction: viewModel.revealLetter, settingsAction: {
                    isSettingsActive.toggle()
                })
                Spacer(minLength: space)
                Tips(viewModel: viewModel)
                Spacer(minLength: space)
                renderGameField()
            }
            if viewModel.isMatched {
                FinalScreen(retryAction: viewModel.createGame)
                    .transition(.asymmetric(insertion: .scale.animation(Animation.easeInOut.delay(0.3)), removal: .scale))
                    .zIndex(1)
            }
            if isSettingsActive {
                Settings(gridSize: viewModel.columns, plusAction: viewModel.increaseColumns, minusAction: viewModel.descreaseColumns, restartAction: viewModel.createGame, doneAction: {
                    isSettingsActive.toggle()
                })
                .zIndex(1)
            }
        }
    }
    
    private func renderGameField() -> some View {
        GeometryReader { geometry in
            HStack {
                renderGrid(size: geometry.size)
            }
            .frame(maxHeight: .infinity)
        }
    }
    
    private func renderGrid(size: CGSize) -> some View {
        let width = size.width
        let height = size.width
        let gridItemWidth = floor((width - CGFloat(viewModel.columns) * cardPadding) / CGFloat(viewModel.columns + 1))
        
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemWidth))], content: {
            ForEach(viewModel.letters) { letter in
                LetterView(letter: letter)
                .onTapGesture {
                    withAnimation(Animation.linear) {
                        viewModel.select(letter: letter)
                    }
                }
                .padding(cardPadding)
                    .aspectRatio(contentMode: .fill)
            }
        })
        .padding(10)
        .frame(width: width, height: height, alignment: .center)
    }
    
    private let topSpace: CGFloat = 15.0
    private let space: CGFloat = 5.0
    private let cardPadding: CGFloat = 5.0
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(viewModel: ViewModel())
            ContentView(viewModel: ViewModel())
                .previewDevice("iPhone 8")
        }
    }
}
