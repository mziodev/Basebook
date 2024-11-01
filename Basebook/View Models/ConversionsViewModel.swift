//
//  ConversionsViewModel.swift
//  Basebook
//
//  Created by MZiO on 29/10/24.
//

import Foundation

class ConversionsViewModel {
    
    static func getConversionSet(for number: Int) -> [RadixConversion] {
        
        var conversionSet: [RadixConversion] = []
        
        Radix.allCases.forEach { radix in
            let conversionValue = RadixConverter.convert(
                number,
                to: radix.value
            )
            
            conversionSet.append(
                RadixConversion(
                    radix: radix,
                    value: conversionValue
                )
            )
        }
        
        return conversionSet
    }
}
