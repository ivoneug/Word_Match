//
//  ViewModel.swift
//  Word Match
//
//  Created by Evgeniy on 01.05.2021.
//

import Foundation

let words = [
    "pie",
    "able",
    "hello",
    "table",
    "lasso",
    "wonderful",
    "blue",
    "rocket",
    "science"
]

class ViewModel: ObservableObject {
    @Published private var model: Model = createModel()
    
    private static func createModel() -> Model {
        let word: String = words[Int.random(in: 0..<words.count)]
        return Model(words: words, columns: 3)
    }
    
    // MARK: - Accessors
    
    var letters: [Model.Letter] {
        model.letters
    }
    
    // MARK: - Intents
    
    func createGame() {
        model = ViewModel.createModel()
    }
    
    func select(letter: Model.Letter) {
        model.select(letter: letter)
    }
}
