//
//  ConversionsViewModel.swift
//  Basebook
//
//  Created by MZiO on 29/10/24.
//

import Foundation

class ConversionsViewModel {
    
    static func calculateRadixConversions(for number: Int) -> [RadixConversion] {
        
        var radixConversions: [RadixConversion] = []
        
        Radix.allCases.forEach { radix in
            let conversionValue = RadixConverter.convert(
                number,
                to: radix.value
            )
            
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
