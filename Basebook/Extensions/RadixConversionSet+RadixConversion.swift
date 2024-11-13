//
//  RadixConversionSet+RadixConversion.swift
//  Basebook
//
//  Created by MZiO on 13/11/24.
//

import Foundation

extension RadixConversionSet {
    func clearRadixConversions() {
        if radixConversions.isEmpty { return }
        
        radixConversions.removeAll()
    }
    
    func loadRadixConversions(from number: String) throws -> ConversionError? {
        if number.isEmpty || number == "0" {
            return ConversionError.zeroNumber
        }
        
        clearRadixConversions()
        
        do {
            let numberInt = try RadixConverter.convert(
                inputNumber,
                from: selectedRadix.value
            )
            
            radixConversions = RadixConversionUtilities.calculateRadixConversions(
                for: numberInt
            )
        } catch let error as ConversionError {
            return error
        }
        
        return nil
    }
}
