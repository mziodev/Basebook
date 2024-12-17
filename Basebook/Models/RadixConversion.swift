//
//  RadixConversion.swift
//  Basebook
//
//  Created by MZiO on 31/10/24.
//

import Foundation

/// A struct representing a single radix conversion result.
///
/// This struct encapsulates the result of converting a number from one
/// radix (base) to another. It includes the radix used for the conversion and
/// the resulting value as a string.
///
/// Properties:
/// - `radix`: The radix (base) used for the conversion, represented as
/// a `Radix` enum value.
/// - `value`: The string representation of the converted value in the specified
/// radix.
///
/// Conformance:
/// - `Codable`: This struct conforms to the `Codable` protocol, allowing it
/// to be easily encoded and decoded for storage or transmission.
struct RadixConversion: Codable {
    var radix: Radix
    var value: String
}
