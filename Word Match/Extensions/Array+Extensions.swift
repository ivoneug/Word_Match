//
//  Array+Extensions.swift
//  MatchMagic
//
//  Created by Evgeniy on 27.04.2021.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if (self[index].id == matching.id) {
                return index
            }
        }
        
        return nil
    }
}
