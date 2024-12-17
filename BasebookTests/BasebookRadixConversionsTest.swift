//
//  BasebookRadixConversionsTest.swift
//  BasebookTests
//
//  Created by MZiO on 17/12/24.
//

import XCTest

@testable import Basebook

final class BasebookRadixConversionsTest: XCTestCase {

    // MARK: calculate function tests

    func testCalculateForZero() {
        let conversions = RadixConversions.calculate(for: 0)
        
        XCTAssertEqual(conversions.count, Radix.allCases.count)
        
        for index in 0..<Radix.allCases.count {
            XCTAssertEqual(conversions[index].value, "0")
        }
    }
    
    func testCalculateForTen() {
        let conversions = RadixConversions.calculate(for: 10)
        
        XCTAssertEqual(conversions.count, Radix.allCases.count)
        
        XCTAssertEqual(conversions[0].value, "1010")  // Binary
        XCTAssertEqual(conversions[1].value, "101")   // Ternary
        XCTAssertEqual(conversions[2].value, "22")    // Quaternary
        XCTAssertEqual(conversions[3].value, "20")    // Quinary
        XCTAssertEqual(conversions[4].value, "14")    // Senary
        XCTAssertEqual(conversions[5].value, "12")    // Octal
        XCTAssertEqual(conversions[6].value, "11")    // Nonary
        XCTAssertEqual(conversions[7].value, "10")    // Decimal
        XCTAssertEqual(conversions[8].value, "a")     // Duodecimal
        XCTAssertEqual(conversions[9].value, "a")     // Hexadecimal
    }
    
    
    func testCalulateForNegativeNumber() {
        let conversions = RadixConversions.calculate(for: -10)
        
        XCTAssertEqual(conversions.count, Radix.allCases.count)
        
        XCTAssertEqual(conversions[0].value, "-1010")  // Binary
        XCTAssertEqual(conversions[1].value, "-101")   // Ternary
        XCTAssertEqual(conversions[2].value, "-22")    // Quaternary
        XCTAssertEqual(conversions[3].value, "-20")    // Quinary
        XCTAssertEqual(conversions[4].value, "-14")    // Senary
        XCTAssertEqual(conversions[5].value, "-12")    // Octal
        XCTAssertEqual(conversions[6].value, "-11")    // Nonary
        XCTAssertEqual(conversions[7].value, "-10")    // Decimal
        XCTAssertEqual(conversions[8].value, "-a")     // Duodecimal
        XCTAssertEqual(conversions[9].value, "-a")     // Hexadecimal
    }
    
    
    // MARK: convert(_:to:) function tests
    
    func testConvertIntToRadix() {
        XCTAssertEqual(RadixConversions.convert(10, to: 2), "1010")
        XCTAssertEqual(RadixConversions.convert(10, to: 8), "12")
        XCTAssertEqual(RadixConversions.convert(255, to: 16), "ff")
        XCTAssertEqual(RadixConversions.convert(0, to: 10), "0")
        XCTAssertEqual(RadixConversions.convert(-10, to: 2), "-1010")
    }
    
    
    // MARK: convert(_:from:) function tests
    
    func testConvertStringFromRadix() {
        XCTAssertEqual(try RadixConversions.convert("1010", from: 2), 10)
        XCTAssertEqual(try RadixConversions.convert("12", from: 8), 10)
        XCTAssertEqual(try RadixConversions.convert("ff", from: 16), 255)
        XCTAssertEqual(try RadixConversions.convert("00010", from: 2), 2)
    }
    
    func testConvertStringFromInvalidRadix() {
        XCTAssertThrowsError(try RadixConversions.convert("10", from: 1)) { error in
            XCTAssertEqual(error as? ConversionError, ConversionError.invalidRadix)
        }
        
        XCTAssertThrowsError(try RadixConversions.convert("10", from: 37)) { error in
            XCTAssertEqual(error as? ConversionError, ConversionError.invalidRadix)
        }
    }
    
    func testConvertStringFromInvalidNumber() {
        XCTAssertThrowsError(try RadixConversions.convert(" 10", from: 10)) { error in
            XCTAssertEqual(error as? ConversionError, ConversionError.invalidNumber)
        }
        
        XCTAssertThrowsError(try RadixConversions.convert("1-0", from: 10)) { error in
            XCTAssertEqual(error as? ConversionError, ConversionError.invalidNumber)
        }
    }

}
