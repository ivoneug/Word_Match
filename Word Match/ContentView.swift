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
                renderHeader()
                Spacer(minLength: space)
                renderTips()
                Spacer(minLength: space)
                renderGameField()
            }
            if viewModel.isMatched {
                renderFinalScreen()
            }
        }
    }
    
    private func renderHeader() -> some View {
        HStack() {
            Button(action: {
                withAnimation(Animation.easeInOut) {
                    viewModel.revealResults()
                }
            }) {
                Image(systemName: "questionmark.diamond")
            }
            .font(Font.title)
            .padding(20)
            
            Text("Find All Words")
                .frame(maxWidth: .infinity)
                .font(Font.title2.bold())
                .frame(maxWidth: .infinity)
            
            Button(action: {
                withAnimation(Animation.easeInOut) {
                    viewModel.createGame()
                }
            }) {
                Image(systemName: "arrow.triangle.2.circlepath")
            }
            .font(Font.title)
            .padding(20)
        }
        .foregroundColor(.black)
    }
    
    private func renderTips() -> some View {
        let color = viewModel.nextWordToSearch?.color ?? Color.gray
        
        return ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(color.opacity(0.75))
//                .shadow(radius: 5, x: 0, y: 0)
            if let word = viewModel.nextWordToSearch {
                Text(word.description)
                    .padding()
            } else {
                Text("No tips")
                    .padding()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 120, alignment: .center)
        .multilineTextAlignment(.center)
        .foregroundColor(.white)
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
    
    private func renderFinalScreen() -> some View {
        ZStack {
            Color.white
                .opacity(0.8)
                .ignoresSafeArea()
            VStack {
                Text("All Words are Matched!")
                    .font(Font.title.bold())
                Button(action: {
                    viewModel.createGame()
                }) {
                    Image(systemName: "arrow.triangle.2.circlepath")
                }
                .font(Font.title)
                .padding(25)
            }
        }
        .frame(width: .infinity, height: .infinity, alignment: .center)
        .foregroundColor(.black)
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
