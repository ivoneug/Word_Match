//
//  Model.swift
//  Word Match
//
//  Created by Evgeniy on 01.05.2021.
//

import SwiftUI

let alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

let wordList: [Word] = [
    Word(name: "pie", description: "Nice and tasty cake"),
    Word(name: "able", description: "When you can do something then you are *** to do it"),
    Word(name: "hello", description: "A word to greet to someone"),
    Word(name: "table", description: "A piece of furniture which can hold something"),
    Word(name: "lasso", description: "A lasso description"),
    Word(name: "wonderful", description: "A wonderful description"),
    Word(name: "blue", description: "A blue description"),
    Word(name: "rocket", description: "A rocket description"),
    Word(name: "science", description: "A science description"),
    Word(name: "class", description: "A class description"),
    Word(name: "information", description: "An information description"),
    Word(name: "tradition", description: "A tradition description"),
    Word(name: "handle", description: "A handle description"),
    Word(name: "virus", description: "A virus description"),
    Word(name: "locomotive", description: "A locomotive description"),
    Word(name: "car", description: "A car description"),
    Word(name: "tree", description: "A tree description"),
    Word(name: "decimal", description: "A decimal description")
]

let colors = [
    Color.green,
    Color.blue,
    Color.orange,
    Color.pink,
    Color.purple,
    Color.red,
    Color.yellow
]

struct Model {
    enum DirectionType {
        case horizontalForward
        case horizontalBackward
        case verticalForward
        case verticalBackward
    }
    
    let columns: Int
    let rows: Int
    
    private var words = [Word]()
    var selectedWords = [Word]()
    var emptyIndexes = [Int]()
    var letters = [Letter]()
    
    init(columns: Int) {
        self.columns = columns
        self.rows = columns
        self.words.append(contentsOf: wordList)
        
        prepare()
        generate()
    }
    
    private mutating func prepare() {
        letters.removeAll()
        emptyIndexes.removeAll()
        
        words.shuffle()
        
        for index in 0..<self.columns * self.rows {
            letters.append(Letter())
            emptyIndexes.append(index)
        }
        
        emptyIndexes.shuffle()
    }
    
    private mutating func generate() {
        var directions: [DirectionType] = [
            .horizontalBackward,
            .horizontalForward,
            .verticalBackward,
            .verticalForward
        ]
        
        var colorIndex = -1
        
        for var word in words {
            directions.shuffle()
            emptyIndexes.shuffle()
            
            var index: Int?
            var prevIndex: Int = -1
            var indexes = [Int]()
            var letterIndex = 0
            var directionIndex = 0
            
            let wordLetters = word.name.map{ String($0) }
            
            while letterIndex < wordLetters.count {
                if letterIndex == 0 {
                    index = emptyIndexes.first
                } else {
                    index = nextIndex(prevIndex: index!, direction: directions[directionIndex])
                }
                if let exactIndex = index {
                    // make sure that our newvly found index has not been already found :)
                    if indexes.firstIndex(of: exactIndex) == nil {
                        indexes.append(exactIndex)
                        prevIndex = exactIndex
                        
                        letterIndex += 1
                        continue
                    }
                }
                
                directionIndex += 1
                
                assert(prevIndex != -1)
                index = prevIndex
                
                if directionIndex >= directions.count {
                    indexes.removeAll()
                    break
                }
            }
            
            if indexes.count != 0 {
                colorIndex += 1
                if colorIndex >= colors.count {
                    colorIndex = 0
                }
                let color = colors[colorIndex]
                
                word.color = color
                selectedWords.append(word)
                
                for index in 0..<indexes.count {
                    let exactIndex = indexes[index]

                    let letter = Letter(name: wordLetters[index], word: word.name)
                    letters[exactIndex] = letter
                    letters[exactIndex].id = exactIndex
                    letters[exactIndex].color = color
                    
                    for idx in 0..<emptyIndexes.count {
                        if emptyIndexes[idx] == exactIndex {
                            emptyIndexes.remove(at: idx)
                            break
                        }
                    }
                }
            }
            
            if emptyIndexes.count == 0 {
                break
            }
        }
        
        for index in emptyIndexes {
            var letter = Letter()
            letter.name = alphabet[Int.random(in: 0..<alphabet.count)]
            letter.id = index
            
            letters[index] = letter
        }
    }
    
    mutating func select(letter: Letter) {
        if letter.isMatched {
            return
        }
        
        letters[letter.id].isSelected = !letters[letter.id].isSelected
        
        checkForMatch(letter: letter)
    }
    
    mutating func revealResults() {
        for index in 0..<letters.count {
            if letters[index].isFake {
                continue
            }
            
            letters[index].isSelected = true
            letters[index].isMatched = true
        }
    }
    
    private mutating func checkForMatch(letter: Letter) {
        if letter.isFake {
            return
        }
        
        let totalCount = letter.word.count
        var count = 0
        var wordIndexes = [Int]()
        
        for index in 0..<letters.count {
            let currentLetter = letters[index]
            if (currentLetter.word == letter.word) {
                wordIndexes.append(index)
                
                if (currentLetter.isSelected) {
                    count += 1
                }
            }
        }
        
        if count == totalCount {
            for index in wordIndexes {
                letters[index].isMatched = true
            }
            for index in 0..<selectedWords.count {
                if selectedWords[index].name == letter.word {
                    selectedWords[index].isMatched = true
                    break
                }
            }
        }
    }
    
    private mutating func nextIndex(prevIndex: Int, direction: DirectionType) -> Int? {
        let hUpper = Int(ceil(Double(prevIndex + 1) / Double(columns))) * columns
        let hLower = Int(floor(Double(prevIndex + 1) / Double(columns))) * columns
        
        let vUpper = columns * rows
        let vLower = 0
        
        var index: Int?
        
        switch direction {
        case .horizontalForward:
            if prevIndex + 1 < hUpper {
                index = prevIndex + 1
            }
        case .horizontalBackward:
            if prevIndex - 1 >= hLower {
                index = prevIndex - 1
            }
        case .verticalForward:
            if prevIndex + columns < vUpper {
                index = prevIndex + columns
            }
        case .verticalBackward:
            if prevIndex - columns >= vLower {
                index = prevIndex - columns
            }
        }
        
        if index != nil && emptyIndexes.firstIndex(of: index!) != nil {
            return index
        }
        
        return nil
    }
}
