//
//  ViewModel.swift
//  Word Match
//
//  Created by Evgeniy on 01.05.2021.
//

import Foundation

var defaultColumnsCount = 5
var maxColumnsCount = 8
var minColumnsCount = 5

class ViewModel: ObservableObject {
    @Published private var model: Model = createModel(defaultColumnsCount)
    private(set) var columns = defaultColumnsCount
    
    private static func createModel(_ columns: Int) -> Model {
        return Model(columns: columns)
    }
    
    // MARK: - Accessors
    
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
        model = ViewModel.createModel(columns)
    }
    
    func increaseColumns() {
        columns += 1
        if columns > maxColumnsCount {
            columns = maxColumnsCount
            return
        }
        
        createGame()
    }
    
    func descreaseColumns() {
        columns -= 1
        if columns < minColumnsCount {
            columns = minColumnsCount
            return
        }
        
        createGame()
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
