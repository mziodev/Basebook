//
//  RadixConversionSet.swift
//  Basebook
//
//  Created by MZiO on 31/10/24.
//

import Foundation
import SwiftData

/// A model representing a set of radix conversions for a specific input number.
///
/// This class encapsulates the details of a conversion operation, including
/// the input number, the selected radix for conversion, the date of the
/// conversion, and the resulting conversions for the specified input number.
/// It is designed to facilitate the storage and management of conversion data
/// in applications that require number base conversions.
///
/// Properties:
/// - `date`: The date and time when the conversion was performed. Defaults to
/// the current date.
/// - `inputNumber`: The number to be converted, represented as a string.
/// - `selectedRadix`: The radix (base) selected for the conversion. Defaults
/// to decimal (base 10).
/// - `radixConversions`: An array of `RadixConversion` objects representing
/// the results of the conversion.
///
/// Initializer:
/// - `init(date:inputNumber:selectedRadix:radixConversions:)`: Initializes a
/// new instance of `RadixConversionSet` with the specified date, input number,
/// selected radix, and an optional array of radix conversions.
@Model
class RadixConversionSet {
    var date: Date = Date()
    var inputNumber: String = ""
    var selectedRadix: Radix = Radix.decimal
    var radixConversions: [RadixConversion] = []
    
    init(
        date: Date = .now,
        inputNumber: String = "",
        selectedRadix: Radix = .decimal,
        radixConversions: [RadixConversion] = []
    ) {
        self.date = date
        self.inputNumber = inputNumber
        self.selectedRadix = selectedRadix
        self.radixConversions = radixConversions
    }
    
    func copy(from radixConversionSet: RadixConversionSet) {
        date = radixConversionSet.date
        inputNumber = radixConversionSet.inputNumber
        selectedRadix = radixConversionSet.selectedRadix
        radixConversions = radixConversionSet.radixConversions
    }
}
