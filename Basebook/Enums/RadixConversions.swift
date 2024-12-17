//
//  RadixConversions.swift
//  Basebook
//
//  Created by MZiO on 17/12/24.
//

import Foundation

/// A utility enum for converting numbers between different radices (bases).
///
/// This enum provides static methods to facilitate conversions between integer
/// values and their string representations in various bases, ranging from
/// binary (base 2) to base-36. It is designed to support common use cases in
/// number base conversions, such as converting decimal numbers to hexadecimal
/// or binary formats, and vice versa.
///
/// ## Methods
/// - `convert(_:to:)`: Converts an integer to its string representation in the
/// specified radix.
/// - `convert(_:from:)`: Converts a string representation of a number from a
/// specified radix back to an integer.
/// - `calculate(for:)`: Generates an array of `RadixConversion` objects
/// representing the conversions of a given integer to all supported radices.
///
/// - Note: The methods will throw errors for invalid radices or invalid number
/// formats. This enum is particularly useful in applications that require number
/// formatting or conversion for displaying or processing in different numeral
/// systems.
enum RadixConversions {
    
    /// Converts an integer to its string representation in the specified radix.
    ///
    /// This method takes an integer and converts it to a string representation
    /// in the given base. The radix must be between 2 and 36, inclusive.
    /// For example, converting the number 10 to radix 2 will yield "1010", while
    /// converting it to radix 16 will yield "A".
    ///
    /// - Parameters:
    ///   - number: The integer number to be converted.
    ///   - radix: The base (radix) to convert the number to. Must be between
    ///   2 and 36.
    /// - Returns: A string representation of the number in the specified radix.
    /// - Note: The resulting string will use characters '0'-'9' for values 0-9
    /// and 'A'-'Z' for values 10-35.
    static func convert(_ number: Int, to radix: Int) -> String {
        String(number, radix: radix)
    }
    
    /// Converts a string representation of a number from a specified radix to
    /// an integer.
    ///
    /// This method takes a string that represents a number in a specified base
    /// and converts it back to an integer. The radix must be between 2 and 36.
    /// If the string cannot be converted to an integer (e.g., if it contains
    /// invalid characters for the specified base), an error will be thrown.
    ///
    /// - Parameters:
    ///   - number: The string representation of the number to be converted.
    ///   - radix: The base (radix) from which to convert the number. Must be
    ///   between 2 and 36.
    /// - Throws:
    ///   - `ConversionError.invalidRadix` if the radix is not within the range
    ///   of 2 to 36.
    ///   - `ConversionError.invalidNumber` if the string cannot be converted
    ///   to an integer.
    /// - Returns: The integer value of the number represented by the string in
    /// the specified radix.
    /// - Important: The input string must only contain valid characters for the
    /// specified radix.
    static func convert(_ number: String, from radix: Int) throws -> Int {
        guard (2...36).contains(radix) else {
            throw ConversionError.invalidRadix
        }
        
        guard let result = Int(number, radix: radix) else {
            throw ConversionError.invalidNumber
        }
        
        return result
    }
    
    /// Calculates the conversions of a given integer to all supported radices.
    ///
    /// This method generates an array of `RadixConversion` objects, each
    /// representing the conversion of the specified integer to a different base.
    /// It iterates through all
    /// supported radices and uses the `convert(_:to:)` method to perform the
    /// conversions.
    ///
    /// - Parameter number: The integer number to be converted.
    /// - Returns: An array of `RadixConversion` objects representing the number
    /// in different radices.
    /// - Complexity: The method performs a conversion for each supported radix,
    /// resulting in a time complexity of *O(n)*, where *n* is the number
    /// of supported radices (2 to 36).
    static func calculate(for number: Int) -> [RadixConversion] {
        
        var radixConversions: [RadixConversion] = []
        
        Radix.allCases.forEach { radix in
            let conversionValue = convert(number, to: radix.value)
            
            radixConversions.append(
                RadixConversion(
                    radix: radix,
                    value: conversionValue
                )
            )
        }
        
        return radixConversions
    }
}
