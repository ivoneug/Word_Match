//
//  LetterView.swift
//  Word Match
//
//  Created by Evgeniy on 04.06.2021.
//

import SwiftUI

struct LetterView: View {
    var letter: Letter
    
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
