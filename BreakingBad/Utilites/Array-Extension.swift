//
//  Array-Extension.swift
//  BreakingBad
//

import Foundation

extension Array where Element == Character {
    
    /// This function compare a text and filter a 'Character' by name
    /// - Parameter text: a string
    /// - Returns: returns a filtered characters.
    func searchByName(_ text: String?) -> [Character] {
        if let text = text, text.count > 0 {
            return self.filter {
                $0.name.contains(text)
            }
        } else {
            return self
        }
    }
    
    /// This function compare an integer and filter a 'Character' appearance
    /// - Parameter season: an integer
    /// - Returns: reurns a filtered characters matched by season appearance
    func searchByAppearance(_ season: Int?) -> [Character] {
        if let season = season {
            return self.filter {
                ($0.appearance.contains(season))
            }
        } else {
            return self
        }
    }
}
