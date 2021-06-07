//
//  FinalScreen.swift
//  Word Match
//
//  Created by Evgeniy on 06.06.2021.
//

import SwiftUI

struct FinalScreen: View {
    var retryAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.white
                .opacity(0.9)
                .ignoresSafeArea()
            VStack {
                Text("All Words are Matched!")
                    .font(Font.title.bold())
                Button(action: {
                    withAnimation(Animation.easeInOut) {
                        retryAction()
                    }
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
    
}
