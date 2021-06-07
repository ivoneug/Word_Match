//
//  Header.swift
//  Word Match
//
//  Created by Evgeniy on 06.06.2021.
//

import SwiftUI

struct Header: View {
    var revealAction: () -> Void
    var settingsAction: () -> Void
    
    var body: some View {
        HStack() {
            Button(action: {
                withAnimation(Animation.easeInOut) {
                    revealAction()
                }
            }) {
                Image(systemName: "questionmark.diamond")
            }
            .font(Font.title)
            .padding(.horizontal, 20)
            
            Text("Find All Words")
                .frame(maxWidth: .infinity)
                .font(Font.title2.bold())
                .frame(maxWidth: .infinity)
            
            Button(action: {
                withAnimation(Animation.easeInOut) {
                    settingsAction()
                }
            }) {
                Image(systemName: "gearshape")
            }
            .font(Font.title)
            .padding(.horizontal, 20)
        }
        .foregroundColor(.black)
    }
}
