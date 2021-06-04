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
        VStack {
            Spacer(minLength: topSpace)
            HStack() {
                Text("Score: \(0)")
                    .frame(maxWidth: .infinity)
                Text("Find Word")
                    .frame(maxWidth: .infinity)
                    .font(Font.title2)
                Button(action: {
                    withAnimation(Animation.easeInOut) {
                        viewModel.createGame()
                    }
                }) {
                    Text("New Game")
                }
                .frame(maxWidth: .infinity)
            }
            Spacer(minLength: space)
            renderTips()
            Spacer(minLength: space)
            renderGameField()
        }
    }
    
    private func renderTips() -> some View {
        Text("Tip 1")
            .padding()
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

struct LetterView: View {
    var letter: Model.Letter
    
    var body: some View {
        GeometryReader { geometry in
            renderLetter(size: geometry.size)
        }
    }
    
    private func renderLetter(size: CGSize) -> some View {
        ZStack {
            if letter.isSelected {
                RoundedRectangle(cornerRadius: 5)
                    .fill()
                Text(letter.name)
                    .foregroundColor(Color.white)
            } else {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 5)
                    .stroke()
                Text(letter.name)
            }
        }
        .font(Font.system(size: fontSize(for: size)))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(letter.isMatched ? letter.color : .black)
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScale
    }
    
    private let fontScale: CGFloat = 0.75
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
