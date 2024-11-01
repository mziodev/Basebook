//
//  RadixConversionSet.swift
//  Basebook
//
//  Created by MZiO on 31/10/24.
//

import Foundation
import SwiftData

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
}
