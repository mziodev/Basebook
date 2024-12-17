//
//  ConversionError.swift
//  Basebook
//
//  Created by MZiO on 30/10/24.
//

import Foundation

/// An enumeration representing errors that can occur during number conversion
/// operations.
///
/// This enum conforms to the `Error` protocol and defines specific error cases
/// that may arise when performing conversions between different radices (bases).
/// It is designed to provide meaningful error information to developers and
/// users when conversion operations fail.
///
/// The following error cases are defined:
/// - `zeroNumber`: Indicates that the number provided for conversion is zero,
/// which is not valid for certain conversion operations.
/// - `invalidRadix`: Indicates that the specified radix (base) is invalid,
/// meaning it is outside the acceptable range (2 to 36).
/// - `invalidNumber`: Indicates that the number or character provided is
/// invalid for the selected base, which may occur if the input contains
/// characters not allowed in that base.
/// - `unexpectedError`: Indicates that an unexpected error has occurred, which
/// may not fit into the other defined categories.
///
/// Each error case has an associated localized description that provides a
/// user-friendly message to explain the nature of the error. This is useful
/// for displaying error messages in the user interface or logging purposes.
enum ConversionError: Error {
    case zeroNumber
    case invalidRadix
    case invalidNumber
    case unexpectedError
    
    /// A localized description of the error.
    ///
    /// This computed property returns a user-friendly message that describes
    /// the error in detail. The messages are localized to provide better user
    /// experience based on the user's language settings.
    var localizedDescription: String {
        switch self {
        case .zeroNumber:
            String(localized: "Zero is zero in all bases, just try another one.")
        case .invalidRadix:
            String(localized: "Invalid base, please check your base.")
        case .invalidNumber:
            String(localized: "Invalid number/character for the selected base, please check your number/character.")
        case .unexpectedError:
            String(localized: "An unexpected error occurred, please try again.")
        }
    }
}
