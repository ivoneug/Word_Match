//
//  Settings.swift
//  Word Match
//
//  Created by Evgeniy on 07.06.2021.
//

import SwiftUI

extension AnyTransition {
    static var slideVertical: AnyTransition {
        AnyTransition.move(edge: .top)
    }
}

struct Settings: View {
    var gridSize: Int
    var plusAction: () -> Void
    var minusAction: () -> Void
    var restartAction: () -> Void
    var doneAction: () -> Void
    
    private let cornerRadius: CGFloat = 15
    private let rowSpacerHeight: CGFloat = 25
    private let buttonPadding: CGFloat = 20
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil) {
            Spacer(minLength: 44)
            VStack(alignment: .leading, spacing: nil) {
                HStack {
                    Button(action: {
                        withAnimation(Animation.easeInOut) {
                            minusAction()
                        }
                    }) {
                        Image(systemName: "minus.circle")
                    }
                    .padding(.horizontal, buttonPadding)
                    .font(.title)
                    
                    Text("Grid: \(gridSize)x\(gridSize)")
                    
                    Button(action: {
                        withAnimation(Animation.easeInOut) {
                            plusAction()
                        }
                    }) {
                        Image(systemName: "plus.circle")
                    }
                    .padding(.horizontal, buttonPadding)
                    .font(.title)
                }
                Spacer(minLength: rowSpacerHeight)
                HStack {
                    Button(action: {
                        withAnimation(Animation.easeInOut) {
                            restartAction()
                        }
                    }) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                    }
                    .padding(.horizontal, buttonPadding)
                    .font(.title)
                    Text("Restart Game")
                }
            }
            .frame(maxWidth: .infinity)
            Spacer(minLength: rowSpacerHeight)
            Button(action: {
                withAnimation(Animation.easeInOut) {
                    doneAction()
                }
            }, label: {
                Text("Done")
            })
        }
        .font(Font.title2)
        .foregroundColor(.black)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 220)
        .background(Color.white)
        .cornerRadius(cornerRadius, corners: [.bottomLeft, .bottomRight])
        .shadow(radius: 10)
        .ignoresSafeArea()
        .padding(.horizontal)
        .transition(.slideVertical)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(gridSize: 5, plusAction: {}, minusAction: {}, restartAction: {}, doneAction: {})
    }
}
