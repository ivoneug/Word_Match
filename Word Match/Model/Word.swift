//
//  Word.swift
//  Word Match
//
//  Created by Evgeniy on 06.06.2021.
//

import SwiftUI

var wordList: [Word] = [
    Word(name: "pie", description: "Nice and tasty cake"),
    Word(name: "able", description: "When you can do something then you are *** to do it"),
    Word(name: "hello", description: "A word to greet to someone"),
    Word(name: "table", description: "A piece of furniture which can hold something")
]

var isWordsLoaded = false

func loadWords() {
    if isWordsLoaded {
        return
    }
    isWordsLoaded = true
    
    if let path = Bundle.main.path(forResource: "words", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let result = json as? Array<Dictionary<String, String>> {
                
                wordList.removeAll()
                for item in result {
                    if let name = item["name"], let description = item["description"] {
                        let word = Word(name: name, description: description)
                        wordList.append(word)
                    }
                }
            }
        } catch {
            
        }
    }
}


struct Word {
    var name: String
    var description: String
    var color: Color = Color.clear
    var isMatched: Bool = false
}
