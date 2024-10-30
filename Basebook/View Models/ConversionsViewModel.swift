//
//  ConversionsViewModel.swift
//  Basebook
//
//  Created by MZiO on 29/10/24.
//

import Foundation

class ConversionsViewModel {
    
    static func getConversions(for number: Int) -> [(Radix, String)] {
        
        var conversions: [(Radix, String)] = []
        
        Radix.allCases.forEach { radix in
            let conversionValue = RadixConverter.convert(
                number,
                to: radix.value
            )
            
            conversions.append((radix, conversionValue))
        }
        
        return conversions
    }
}
