//
//  ViewModel.swift
//  Word Match
//
//  Created by Evgeniy on 01.05.2021.
//

import Foundation

let defaultColumnsCount = 5
let maxColumnsCount = 8
let minColumnsCount = 5

struct GameSettings {
    private static let kWordGridColumnsSize = "WordGridColumnsSize"
    
    var columns = defaultColumnsCount {
        didSet {
            UserDefaults.standard.setValue(columns, forKey: GameSettings.kWordGridColumnsSize)
        }
    }
    
    init() {
        columns = UserDefaults.standard.integer(forKey: GameSettings.kWordGridColumnsSize)
        if columns == 0 {
            columns = defaultColumnsCount
        }
    }
}

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
        settings.columns += 1
        if settings.columns > maxColumnsCount {
            settings.columns = maxColumnsCount
            return
        }
        
        createGame()
    }
    
    func descreaseColumns() {
        settings.columns -= 1
        if settings.columns < minColumnsCount {
            settings.columns = minColumnsCount
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
