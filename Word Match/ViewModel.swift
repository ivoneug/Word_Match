//
//  ViewModel.swift
//  Word Match
//
//  Created by Evgeniy on 01.05.2021.
//

import Foundation

class ViewModel: ObservableObject {
    @Published private var model: Model = createModel()
    
    private static func createModel() -> Model {
        return Model(columns: 5)
    }
    
    // MARK: - Accessors
    
    var columns: Int {
        model.columns
    }
    
    var letters: [Letter] {
        model.letters
    }
    
    var nextWordToSearch: Word? {
        return model.nextWordToSearch
    }
    
    var isMatched: Bool {
        return model.isMatched
    }
    
    // MARK: - Intents
    
    func createGame() {
        model = ViewModel.createModel()
    }
    
    func select(letter: Letter) {
        model.select(letter: letter)
    }
    
    func revealLetter() {
        model.revealLetter()
    }
    
    func revealResults() {
        model.revealResults()
    }
}
