//
//  Settings.swift
//  Word Match
//
//  Created by Evgeniy on 07.06.2021.
//

import SwiftUI

struct Settings: View {

    // MARK: - Properties
    var gridSize: Int
    var plusAction: () -> Void
    var minusAction: () -> Void
    var restartAction: () -> Void
    var doneAction: () -> Void
    private let cornerRadius: CGFloat = 15
    private let rowSpacerHeight: CGFloat = 25
    private let buttonPadding: CGFloat = 20
    @State private var panelVisible: Bool = false

    // MARK: - Layout
    var body: some View {
        ZStack(alignment: .top) {
            Color.black
                .opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    saveChanges()
                }

            if panelVisible {
                VStack(alignment: .leading, spacing: nil) {
                    Spacer(minLength: 44)
                    VStack(alignment: .leading, spacing: nil) {
                        HStack {
                            Button(action: {
                                withAnimation {
                                    minusAction()
                                }
                            }) {
                                Image(systemName: "minus.circle")
                            }
                            .padding(.horizontal, buttonPadding)
                            .font(.title)

                            Text("Grid: \(gridSize)x\(gridSize)")

                            Button(action: {
                                withAnimation {
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
                                withAnimation {
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
                    Button(action: saveChanges, label: {
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
                .transition(Constants.slideVerticalTop)
                .zIndex(1)
            }
        }
        .onAppear {
            showPanel()
        }
    }

    private func showPanel() {
        withAnimation {
            panelVisible = true
        }
    }

    private func saveChanges() {
        withAnimation {
            panelVisible = false
            doneAction()
        }
    }

}

private enum Constants {
    static let slideVerticalTop = AnyTransition.move(edge: .top).combined(with: .opacity)
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(gridSize: 5, plusAction: {}, minusAction: {}, restartAction: {}, doneAction: {})
    }
}
