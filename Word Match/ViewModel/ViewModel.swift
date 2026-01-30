//
//  ViewModel.swift
//  Word Match
//
//  Created by Evgeniy on 01.05.2021.
//

import Foundation

class ViewModel: ObservableObject {
    @Published private var model: Model
    private var settings = GameSettings()
    
    private static func createModel(_ columns: Int) -> Model {
        return Model(columns: columns)
    }
    
    init() {
        model = ViewModel.createModel(settings.columns)
    }
    
    // MARK: - Accessors
    
    var columns: Int {
        settings.columns
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
        model = ViewModel.createModel(settings.columns)
    }
    
    func increaseColumns() {
        if settings.increaseColumns() {
            createGame()
        }
    }
    
    func descreaseColumns() {
        if settings.descreaseColumns() {
            createGame()
        }
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
