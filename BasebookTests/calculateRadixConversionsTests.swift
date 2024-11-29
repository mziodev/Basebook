//
//  calculateRadixConversionsTests.swift
//  BasebookTests
//
//  Created by MZiO on 30/10/24.
//

import XCTest
@testable import Basebook

final class calculateRadixConversionsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCalculateRadixConversionsForZero() {
        let conversions = RadixConversionUtilities.calculateRadixConversions(for: 0)
        
        XCTAssertEqual(conversions.count, Radix.allCases.count)
        
        for index in 0..<Radix.allCases.count {
            XCTAssertEqual(conversions[index].value, "0")
        }
    }
    
    func testCalculateRadixConversionsForTen() {
        let conversions = RadixConversionUtilities.calculateRadixConversions(for: 10)
        
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
    
    
    func testCalculateRadixConversionsForNegativeNumber() {
        let conversions = RadixConversionUtilities.calculateRadixConversions(for: -10)
        
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

}
