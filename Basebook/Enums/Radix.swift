//
//  Radix.swift
//  Basebook
//
//  Created by MZiO on 28/10/24.
//

import Foundation

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
    
    // 0: under or decimal type, 1: over decimal type
    var type: Int {
        switch self {
        case .binary:
            0
        case .ternary:
            0
        case .quaternary:
            0
        case .quinary:
            0
        case .senary:
            0
        case .octal:
            0
        case .nonary:
            0
        case .decimal:
            0
        case .duodecimal:
            1
        case .hexadecimal:
            1
        }
    }
}
