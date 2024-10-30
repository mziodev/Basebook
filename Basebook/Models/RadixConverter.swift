//
//  RadixConverter.swift
//  Basebook
//
//  Created by MZiO on 26/10/24.
//

import Foundation

struct RadixConverter {
    
    static func convert(_ number: Int, to radix: Int) -> String {
        String(number, radix: radix)
    }
    
    static func convert(_ number: String, from radix: Int) throws -> Int {
        guard (2...36).contains(radix) else {
            throw ConversionError.invalidRadix
        }
        
        guard let result = Int(number, radix: radix) else {
            throw ConversionError.invalidNumber
        }
        
        return result
    }
}
