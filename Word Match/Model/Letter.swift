//
//  Letter.swift
//  Word Match
//
//  Created by Evgeniy on 06.06.2021.
//

import SwiftUI

struct Letter: Identifiable {
    var id: Int
    var name: String {
        didSet {
            name = name.uppercased()
        }
    }
    var word: String
    var color: Color
    var isSelected: Bool = false
    var isMatched: Bool = false
    
    var isAssigned: Bool {
        id != -1
    }
    
    var isEmpty: Bool {
        return id == -1 && name == "" && word == ""
    }
    var isFake: Bool {
        word.isEmpty
    }
    
    mutating func clear() {
        id = -1
        name = ""
        word = ""
        color = Color.black
        isSelected = false
        isMatched = false
    }
    
    init() {
        id = -1
        name = ""
        word = ""
        color = Color.black
    }
    
    init(name: String, word: String) {
        id = -1
        self.name = name.uppercased()
        self.word = word
        color = Color.black
    }
}
