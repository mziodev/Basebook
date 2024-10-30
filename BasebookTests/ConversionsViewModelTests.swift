//
//  ConversionsViewModelTests.swift
//  BasebookTests
//
//  Created by MZiO on 30/10/24.
//

import XCTest
@testable import Basebook

final class ConversionsViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetConversionsForZero() {
        let conversions = ConversionsViewModel.getConversions(for: 0)
        
        XCTAssertEqual(conversions.count, Radix.allCases.count)
        
        for index in 0..<Radix.allCases.count {
            XCTAssertEqual(conversions[index].1, "0")
        }
    }
    
    func testGetConversionsForTen() {
        let conversions = ConversionsViewModel.getConversions(for: 10)
        
        XCTAssertEqual(conversions.count, Radix.allCases.count)
        
        XCTAssertEqual(conversions[0].1, "1010")  // Binary
        XCTAssertEqual(conversions[1].1, "101")   // Ternary
        XCTAssertEqual(conversions[2].1, "22")    // Quaternary
        XCTAssertEqual(conversions[3].1, "20")    // Quinary
        XCTAssertEqual(conversions[4].1, "14")    // Senary
        XCTAssertEqual(conversions[5].1, "12")    // Octal
        XCTAssertEqual(conversions[6].1, "11")    // Nonary
        XCTAssertEqual(conversions[7].1, "10")    // Decimal
        XCTAssertEqual(conversions[8].1, "a")     // Duodecimal
        XCTAssertEqual(conversions[9].1, "a")     // Hexadecimal
    }
    
    
    func testGetConversionsForNegativeNumber() {
        let conversions = ConversionsViewModel.getConversions(for: -10)
        
        XCTAssertEqual(conversions.count, Radix.allCases.count)
        
        XCTAssertEqual(conversions[0].1, "-1010")  // Binary
        XCTAssertEqual(conversions[1].1, "-101")   // Ternary
        XCTAssertEqual(conversions[2].1, "-22")    // Quaternary
        XCTAssertEqual(conversions[3].1, "-20")    // Quinary
        XCTAssertEqual(conversions[4].1, "-14")    // Senary
        XCTAssertEqual(conversions[5].1, "-12")    // Octal
        XCTAssertEqual(conversions[6].1, "-11")    // Nonary
        XCTAssertEqual(conversions[7].1, "-10")    // Decimal
        XCTAssertEqual(conversions[8].1, "-a")     // Duodecimal
        XCTAssertEqual(conversions[9].1, "-a")     // Hexadecimal
    }

}
