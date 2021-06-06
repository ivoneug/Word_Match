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
        for word in model.selectedWords {
            if !word.isMatched {
                return word
            }
        }
        
        return nil
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
    
    func revealResults() {
        model.revealResults()
    }
}
