//
//  Character.swift
//  BreakingBad
//
//  Created by Essa Aldo on 6/3/21.
//

import Foundation

struct Character: Codable {
    let name: String?
    let occupation: [String]?
    let status: String?
    let nickname: String?
    let appearance: [Int]?
    let img: String?
}


extension Array where Element == Character {
    func searchByName(_ text: String?) -> [Character] {
        if let text = text, text.count > 0 {
            return self.filter {
                $0.name!.contains(text)
            }
        } else {
            return self
        }
    }
    
    func searchByAppearance(_ season: Int?) -> [Character] {
        if let season = season {
            return self.filter {
                ($0.appearance?.contains(season))!
            }
        } else {
            return self
        }
    }
}
