//
//  GameSettings.swift
//  Word Match
//
//  Created by Evgeniy on 08.06.2021.
//

import Foundation

struct GameSettings {
    private static let kWordGridColumnsSize = "WordGridColumnsSize"
    
    private(set) var columns = defaultColumnsCount {
        didSet {
            UserDefaults.standard.set(columns, forKey: GameSettings.kWordGridColumnsSize)
            UserDefaults.standard.synchronize()
        }
    }
    
    init() {
        columns = UserDefaults.standard.integer(forKey: GameSettings.kWordGridColumnsSize)
        if columns == 0 {
            columns = defaultColumnsCount
        }
    }
    
    mutating func increaseColumns() -> Bool {
        columns += 1
        return checkForConstraints()
    }
    
    mutating func descreaseColumns() -> Bool {
        columns -= 1
        return checkForConstraints()
    }
    
    private mutating func checkForConstraints() -> Bool {
        if columns > maxColumnsCount {
            columns = maxColumnsCount
            return false
        }
        if columns < minColumnsCount {
            columns = minColumnsCount
            return false
        }
        
        return true
    }
}
