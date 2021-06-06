//
//  Header.swift
//  Word Match
//
//  Created by Evgeniy on 06.06.2021.
//

import SwiftUI

struct Header: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
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
}
