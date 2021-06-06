//
//  ContentView.swift
//  Word Match
//
//  Created by Evgeniy on 01.05.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            Color.yellow
                .opacity(0.3)
                .ignoresSafeArea()
            VStack {
                Spacer(minLength: topSpace)
                Header(viewModel: viewModel)
                Spacer(minLength: space)
                Tips(viewModel: viewModel)
                Spacer(minLength: space)
                renderGameField()
            }
            if viewModel.isMatched {
                FinalScreen(viewModel: viewModel)
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
        var height = size.width
        var gridItemWidth = width / CGFloat(viewModel.columns + 1)
        
        let rowCount = Int(ceil(Double(viewModel.letters.count) / Double(viewModel.columns)))
        if rowCount != viewModel.columns {
            height = height / CGFloat(viewModel.columns) * CGFloat(rowCount)
        }
        if viewModel.letters.count <= (viewModel.columns + 1) {
            height = width
            gridItemWidth = width / CGFloat(viewModel.columns)
        }
        
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
