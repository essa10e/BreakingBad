//
//  Character.swift
//  BreakingBad
//
//  Created by Essa Aldo on 6/3/21.
//

import Foundation

struct Character: Codable {
    let name: String
    let occupation: [String]
    let status: String
    let nickname: String
    let appearance: [Int]
    let img: URL
}
