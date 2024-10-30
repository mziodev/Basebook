//
//  RadixConverterTests.swift
//  BasebookTests
//
//  Created by MZiO on 28/10/24.
//

import XCTest
@testable import Basebook

final class RadixConverterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConvertIntToRadix() {
        
        XCTAssertEqual(RadixConverter.convert(10, to: 2), "1010")
        XCTAssertEqual(RadixConverter.convert(10, to: 8), "12")
        XCTAssertEqual(RadixConverter.convert(255, to: 16), "ff")
        XCTAssertEqual(RadixConverter.convert(0, to: 10), "0")
        XCTAssertEqual(RadixConverter.convert(-10, to: 2), "-1010")
    }
    
    func testConvertStringFromRadix() {
        
        XCTAssertEqual(try RadixConverter.convert("1010", from: 2), 10)
        XCTAssertEqual(try RadixConverter.convert("12", from: 8), 10)
        XCTAssertEqual(try RadixConverter.convert("ff", from: 16), 255)
        XCTAssertEqual(try RadixConverter.convert("00010", from: 2), 2)
    }
    
    func testConvertStringFromInvalidRadix() {
        
        XCTAssertThrowsError(try RadixConverter.convert("10", from: 1)) { error in
            XCTAssertEqual(error as? ConversionError, ConversionError.invalidRadix)
        }
        
        XCTAssertThrowsError(try RadixConverter.convert("10", from: 37)) { error in
            XCTAssertEqual(error as? ConversionError, ConversionError.invalidRadix)
        }
    }
    
    func testConvertStringFromInvalidNumber() {
        
        XCTAssertThrowsError(try RadixConverter.convert(" 10", from: 10)) { error in
            XCTAssertEqual(error as? ConversionError, ConversionError.invalidNumber)
        }
        
        XCTAssertThrowsError(try RadixConverter.convert("1-0", from: 10)) { error in
            XCTAssertEqual(error as? ConversionError, ConversionError.invalidNumber)
        }
    }
}
