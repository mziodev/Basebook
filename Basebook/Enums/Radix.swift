//
//  Radix.swift
//  Basebook
//
//  Created by MZiO on 28/10/24.
//

import SwiftUI

enum Radix: String, CaseIterable {
    
    case binary
    case ternary
    case quaternary
    case quinary
    case senary
    case octal
    case nonary
    case decimal
    case duodecimal
    case hexadecimal
    
    var numberName: String {
        String(self.value)
    }
    
    var localizedName: String {
        switch self {
        case .binary:
            String(localized: "Binary", comment: "Feminine version of Binary")
        case .ternary:
            String(localized: "Ternary", comment: "Feminine version of Ternary")
        case .quaternary:
            String(
                localized: "Quaternary",
                comment: "Feminine version of Quaternary"
            )
        case .quinary:
            String(localized: "Quinary", comment: "Feminine version of Quinary")
        case .senary:
            String(localized: "Senary", comment: "Feminine version of Senary")
        case .octal:
            String(localized: "Octal", comment: "Feminine version of Octal")
        case .nonary:
            String(localized: "Nonary", comment: "Feminine version of Nonary")
        case .decimal:
            String(localized: "Decimal", comment: "Feminine version of Decimal")
        case .duodecimal:
            String(
                localized: "Duodecimal",
                comment: "Feminine version of Duodecimal"
            )
        case .hexadecimal:
            String(
                localized: "Hexadecimal",
                comment: "Feminine version of Hexadecimal"
            )
        }
    }
    
    var value: Int {
        switch self {
        case .binary: 2
        case .ternary: 3
        case .quaternary: 4
        case .quinary: 5
        case .senary: 6
        case .octal: 8
        case .nonary: 9
        case .decimal: 10
        case .duodecimal: 12
        case .hexadecimal: 16
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .binary, .ternary, .quaternary, .quinary, .senary, .octal, .nonary, .decimal:
                .numberPad
        case .duodecimal, .hexadecimal:
                .numbersAndPunctuation
        }
    }
}
