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
    
    static func convert(_ number: String, from radix: Int) -> Int? {
        guard (2...36).contains(radix) else { return nil }
        
        return Int(number, radix: radix)
    }
}
