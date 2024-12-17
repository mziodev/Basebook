//
//  Radix.swift
//  Basebook
//
//  Created by MZiO on 28/10/24.
//

import SwiftUI

/// An enumeration representing different number radices (bases) used in
/// numeral systems.
///
/// This enum conforms to `String`, `Codable`, and `CaseIterable`, allowing it
/// to represent various bases from binary (base 2) to hexadecimal (base 16).
/// Each case corresponds to a specific radix and provides additional properties
/// to facilitate conversions and user interface interactions.
///
/// The following properties are available:
/// - `numberName`: Returns the string representation of the radix value.
/// - `localizedName`: Provides a localized name for the radix, suitable for
/// display in the user interface.
/// - `value`: Returns the integer value of the radix, which corresponds to its
/// base (e.g., binary is 2).
/// - `keyboardType`: Returns the appropriate keyboard type for user input
/// based on the radix.
///
/// The enum includes the following cases:
/// - `binary`: Base 2
/// - `ternary`: Base 3
/// - `quaternary`: Base 4
/// - `quinary`: Base 5
/// - `senary`: Base 6
/// - `octal`: Base 8
/// - `nonary`: Base 9
/// - `decimal`: Base 10
/// - `duodecimal`: Base 12
/// - `hexadecimal`: Base 16
enum Radix: String, Codable, CaseIterable {
    
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
    
    /// Returns the string representation of the radix value.
    var numberName: String {
        String(self.value)
    }
    
    /// Provides a localized name for the radix, suitable for display in the
    /// user interface.
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
    
    /// Returns the integer value of the radix, which corresponds to its base.
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
    
    /// Returns the appropriate keyboard type for user input based on the radix.
    var keyboardType: UIKeyboardType {
        switch self {
        case .binary, .ternary, .quaternary, .quinary, .senary, .octal, .nonary, .decimal:
                .numberPad
        case .duodecimal, .hexadecimal:
                .numbersAndPunctuation
        }
    }
}
