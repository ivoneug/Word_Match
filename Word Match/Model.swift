//
//  Model.swift
//  Word Match
//
//  Created by Evgeniy on 01.05.2021.
//

import Foundation

struct Model {
    enum DirectionType {
        case horizontalForward
        case horizontalBackward
        case verticalForward
        case verticalBackward
    }
    
    let columns: Int
    var words = [Word]()
    var selectedWords = [Word]()
    var vacantLetterIndexes = [Int]()
    
    var letters: [Letter] {
        var arr = [Letter]()
        
        for index in 0..<selectedWords.count {
            let word = selectedWords[index]
            for letterIndex in 0..<word.letters.count {
                arr.append(word.letters[letterIndex])
            }
        }
        
        arr.sort { x, y in x.id < y.id }
        return arr
    }
    
    init(words: [String], columns: Int) {
        self.columns = columns
        
        for index in 0..<words.count {
            let word = Word(word: words[index])
            self.words.append(word);
        }
        
        self.words.shuffle()
        
        for index in 0..<columns * columns {
            vacantLetterIndexes.append(index)
        }
        
        for index in 0..<self.words.count {
            if vacantLetterIndexes.count == 0 {
                return
            }
            
            for letterIndex in 0..<self.words[index].letters.count {
                if let idx = nextLetterIndex(word: self.words[index], wordLetterIndex: letterIndex) {
                    self.words[index].letters[letterIndex].id = idx
                    vacantLetterIndexes.remove(at: vacantLetterIndexes.firstIndex(of: idx)!)
                } else {
                    self.words[index].clear()
                    break
                }
                
                if letterIndex == self.words[index].letters.count - 1 {
                    selectedWords.append(self.words[index])
                }
            }
        }
    }
    
    mutating func select(letter: Letter) {
        for index in 0..<selectedWords.count {
            for letterIndex in 0..<selectedWords[index].letters.count {
                if letter.id != selectedWords[index].letters[letterIndex].id {
                    continue
                }
                
                selectedWords[index].letters[letterIndex].isSelected = !selectedWords[index].letters[letterIndex].isSelected
            }
        }
    }
    
    private mutating func nextLetterIndex(word: Word, wordLetterIndex: Int) -> Int? {
        let letter = word.letters[wordLetterIndex]
        if letter.isAssigned {
            return letter.id
        }
        
        var prevLetterIndex = -1
        
        if wordLetterIndex == 0 {
            prevLetterIndex = vacantLetterIndexes.randomElement()!
        } else {
            prevLetterIndex = word.letters[wordLetterIndex - 1].id
        }
        
        var attempt = 0
        
        while true {
            attempt += 1
            if attempt > 500 {
                break
            }
            
            let rnd = Int.random(in: 0...3)
            var direction: DirectionType
            
            switch rnd {
            case 0:
                direction = .horizontalForward
            case 1:
                direction = .horizontalBackward
            case 2:
                direction = .verticalForward
            case 3:
                direction = .verticalBackward
            default:
                continue
            }
            
            if let nextVacantIndex = nextIndex(prevIndex: prevLetterIndex, direction: direction) {
                return nextVacantIndex
            }
        }
        
        return nil
    }
    
    private mutating func nextIndex(prevIndex: Int, direction: DirectionType) -> Int? {
        let hUpper = Int(ceil(Double(prevIndex) / Double(columns))) * columns
        let hLower = Int(floor(Double(prevIndex) / Double(columns))) * columns
        
        let vUpper = columns * columns
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
        
        if index != nil && vacantLetterIndexes.firstIndex(of: index!) != nil {
            return index
        }
        
        return nil
    }
    
//    private mutating func vacantLetterIndexes() -> [Int] {
//        var indexes = [Int]()
//        for index in 0..<columns * columns {
//            indexes.append(index)
//        }
//
//        for wordIndex in 0..<selectedWords.count {
//            let word = selectedWords[wordIndex]
//
//            for letterIndex in 0..<word.letters.count {
//                let letter = word.letters[letterIndex]
//
//                if (letter.isAssigned) {
//                    indexes.remove(at: indexes.firstIndex(of: letter.id)!)
//                    selectedWords[wordIndex].letters[letterIndex].clear()
//                }
//            }
//        }
//
//        return indexes
//    }
    
    struct Letter: Identifiable {
        var id: Int
        var name: String
        var isSelected: Bool = false
        var isMatched: Bool = false
        
        var isAssigned: Bool {
            id != -1
        }
        
        mutating func clear() {
            id = -1
        }
    }
    
    struct Word {
        var letters = [Letter]()
        var count: Int {
            letters.count
        }
        var isMatched: Bool {
            var selected = 0
            for index in 0..<letters.count {
                if (letters[index].isSelected) {
                    selected += 1
                }
            }
            
            return selected == letters.count
        }
        
        init(word: String) {
            let letters = word.map{ String($0) };
            for index in 0..<word.count {
                self.letters.append(Letter(id: -1, name: letters[index]))
            }
        }
        
        mutating func clear() {
            for index in 0..<letters.count {
                letters[index].clear()
            }
        }
    }
}
