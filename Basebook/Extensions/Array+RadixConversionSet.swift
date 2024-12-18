//
//  Array+RadixConversionSet.swift
//  Basebook
//
//  Created by MZiO on 18/12/24.
//

import Foundation

extension Array where Element: RadixConversionSet {
    
    /// Checks if the array contains an element that matches the specified
    /// input number and selected radix.
    ///
    /// This function returns a Boolean value indicating whether there is at
    /// least one element in the array that has an `inputNumber` property equal
    /// to the provided `inputNumber` and a `selectedRadix.value` property equal
    /// to the provided `selectedRadix`.
    ///
    /// - Parameters:
    ///   - inputNumber: A `String` representing the input number to check for.
    ///   - selectedRadix: An `Int` representing the radix value to check for.
    ///
    /// - Returns: `true` if the array contains an element that matches the
    /// criteria; otherwise, `false`.
    ///
    /// - Note: The function performs a shallow search and does not modify
    /// the original array.
    func containsSet(with inputNumber: String, selectedRadix: Int) -> Bool {
        
        self.contains {
            $0.inputNumber == inputNumber && $0.selectedRadix.value == selectedRadix
        }
    }
    
    /// Retrieves the first element that matches the specified input number and selected radix.
    ///
    /// This function searches the array for the first element that has an `inputNumber` property
    /// equal to the provided `inputNumber` and a `selectedRadix.value` property equal to the provided
    /// `selectedRadix`. If a matching element is found, it is returned; otherwise, `nil` is returned.
    ///
    /// - Parameters:
    ///   - inputNumber: A `String` representing the input number to search for.
    ///   - selectedRadix: An `Int` representing the radix value to search for.
    ///
    /// - Returns: The first element that matches the criteria, or `nil` if no matching element is found.
    ///
    /// - Note: The function performs a shallow search and does not modify the original array.
    func getSet(with inputNumber: String, selectedRadix: Int) -> Element? {
        
        self.first {
            $0.inputNumber == inputNumber && $0.selectedRadix.value == selectedRadix
        }
    }
}
