//
//  RadixConversionSet+SampleData.swift
//  Basebook
//
//  Created by MZiO on 4/11/24.
//

import Foundation

extension RadixConversionSet {
    
    /// A static property that provides sample data for testing and demonstration
    /// purposes.
    ///
    /// This property contains an array of `RadixConversionSet` instances, each
    /// initialized with different input numbers, selected radices, and their
    /// corresponding conversions. It can be used to quickly populate a user
    /// interface or for testing purposes without needing to perform actual conversions.
    ///
    /// The sample data includes:
    /// - A conversion set for the decimal number "5" with conversions to various
    /// bases.
    /// - A conversion set for the hexadecimal number "A" with conversions to
    /// various bases.
    /// - A conversion set for the decimal number "15" with conversions to various
    /// bases.
    /// - A conversion set for the binary number "1101" with conversions to various
    /// bases.
    /// - A conversion set for the decimal number "20" with conversions to various
    /// bases.
    static let sampleData: [RadixConversionSet] = [
        RadixConversionSet(
            date: .now - (86400 * 10),
            inputNumber: "5",
            selectedRadix: .decimal,
            radixConversions: [
                RadixConversion(radix: .binary, value: "101"),
                RadixConversion(radix: .ternary, value: "12"),
                RadixConversion(radix: .quaternary, value: "11"),
                RadixConversion(radix: .quinary, value: "10"),
                RadixConversion(radix: .senary, value: "5"),
                RadixConversion(radix: .octal, value: "5"),
                RadixConversion(radix: .nonary, value: "5"),
                RadixConversion(radix: .decimal, value: "5"),
                RadixConversion(radix: .duodecimal, value: "5"),
                RadixConversion(radix: .hexadecimal, value: "5"),
            ]
        ),
        RadixConversionSet(
            date: .now - (86400 * 7),
            inputNumber: "A",
            selectedRadix: .hexadecimal,
            radixConversions: [
                RadixConversion(radix: .binary, value: "1010"),
                RadixConversion(radix: .ternary, value: "101"),
                RadixConversion(radix: .quaternary, value: "22"),
                RadixConversion(radix: .quinary, value: "20"),
                RadixConversion(radix: .senary, value: "14"),
                RadixConversion(radix: .octal, value: "12"),
                RadixConversion(radix: .nonary, value: "11"),
                RadixConversion(radix: .decimal, value: "10"),
                RadixConversion(radix: .duodecimal, value: "A"),
                RadixConversion(radix: .hexadecimal, value: "A"),
            ]
        ),
        RadixConversionSet(
            date: .now - (86400 * 5),
            inputNumber: "15",
            selectedRadix: .decimal,
            radixConversions: [
                RadixConversion(radix: .binary, value: "1111"),
                RadixConversion(radix: .ternary, value: "120"),
                RadixConversion(radix: .quaternary, value: "33"),
                RadixConversion(radix: .quinary, value: "30"),
                RadixConversion(radix: .senary, value: "23"),
                RadixConversion(radix: .octal, value: "17"),
                RadixConversion(radix: .nonary, value: "16"),
                RadixConversion(radix: .decimal, value: "15"),
                RadixConversion(radix: .duodecimal, value: "13"),
                RadixConversion(radix: .hexadecimal, value: "F"),
            ]
        ),
        RadixConversionSet(
            date: .now - (86400 * 2),
            inputNumber: "1101",
            selectedRadix: .binary,
            radixConversions: [
                RadixConversion(radix: .binary, value: "1101"),
                RadixConversion(radix: .ternary, value: "111"),
                RadixConversion(radix: .quaternary, value: "31"),
                RadixConversion(radix: .quinary, value: "23"),
                RadixConversion(radix: .senary, value: "21"),
                RadixConversion(radix: .octal, value: "15"),
                RadixConversion(radix: .nonary, value: "14"),
                RadixConversion(radix: .decimal, value: "13"),
                RadixConversion(radix: .duodecimal, value: "11"),
                RadixConversion(radix: .hexadecimal, value: "D"),
            ]
        ),
        RadixConversionSet(
            date: .now,
            inputNumber: "20",
            selectedRadix: .decimal,
            radixConversions: [
                RadixConversion(radix: .binary, value: "10100"),
                RadixConversion(radix: .ternary, value: "202"),
                RadixConversion(radix: .quaternary, value: "110"),
                RadixConversion(radix: .quinary, value: "40"),
                RadixConversion(radix: .senary, value: "32"),
                RadixConversion(radix: .octal, value: "24"),
                RadixConversion(radix: .nonary, value: "22"),
                RadixConversion(radix: .decimal, value: "20"),
                RadixConversion(radix: .duodecimal, value: "18"),
                RadixConversion(radix: .hexadecimal, value: "14"),
            ]
        ),
    ]
}
