//
//  Tips.swift
//  Word Match
//
//  Created by Evgeniy on 06.06.2021.
//

import SwiftUI

struct Tips: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
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
}
