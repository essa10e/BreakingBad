//
//  Character.swift
//  BreakingBad
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
