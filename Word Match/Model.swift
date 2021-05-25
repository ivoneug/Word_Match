//
//  Model.swift
//  Word Match
//
//  Created by Evgeniy on 01.05.2021.
//

import Foundation

struct Model {
    var letters = [Letter]()
    
    init(letters: [String]) {
        for index in 0..<letters.count {
            self.letters.append(Letter(id: index, name: letters[index]))
        }
    }
    
    mutating func select(letter: Letter) {
        for index in 0..<letters.count {
            if letter.id != letters[index].id {
                continue
            }
            
            letters[index].isSelected = !letters[index].isSelected
        }
    }
    
    struct Letter: Identifiable {
        var id: Int
        var name: String
        var isSelected: Bool = false
        var isMatched: Bool = false
    }
    
    struct Word {
        
    }
}
