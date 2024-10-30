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
    
    var name: String {
        self.rawValue.capitalized        
    }
    
    var numberName: String {
        String(self.value)
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
