//
//  ConversionError.swift
//  Basebook
//
//  Created by MZiO on 30/10/24.
//

import Foundation

enum ConversionError: Error {
    case zeroNumber
    case invalidRadix
    case invalidNumber
    case unexpectedError
    
    var localizedDescription: String {
        switch self {
        case .zeroNumber:
            String(localized: "Zero is zero in all bases, just try another one.")
        case .invalidRadix:
            String(localized: "Invalid radix, please check your radix.")
        case .invalidNumber:
            String(localized: "Invalid number for the selected radix, please check your number.")
        case .unexpectedError:
            String(localized: "An unexpected error occurred, please try again.")
        }
    }
}