//
//  Array+Extensions.swift
//  MatchMagic
//
//  Created by Evgeniy on 27.04.2021.
//

import Foundation

extension Array where Element: Identifiable {
    mutating func removeFirstItem(matching: Element) -> Element? {
        var idx: Int?
        
        for index in 0..<self.count {
            if (self[index].id == matching.id) {
                idx = index
                break
            }
        }
        
        if let index = idx {
            return self.remove(at: index)
        } else {
            return nil
        }
    }
}
