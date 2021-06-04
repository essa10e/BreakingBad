//
//  ErrorMessage.swift
//  BreakingBad
//
//  Created by Essa Aldo on 6/3/21.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidData = "The data received from the server was invalid. Please try again"
    case invalidResponse = "Invalid response from the server. Please try again"
    case unableToComplet = "Unable to complete your request."
}
