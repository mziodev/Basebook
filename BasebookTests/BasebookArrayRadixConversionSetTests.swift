//
//  BasebookArrayRadixConversionSetTests.swift
//  BasebookTests
//
//  Created by MZiO on 18/12/24.
//

import XCTest

@testable import Basebook

final class BasebookArrayRadixConversionSetTests: XCTestCase {

    func testContainsSetWithMatchingElement() {
        // Arrange
        let elements: [RadixConversionSet] = [
            RadixConversionSet(inputNumber: "42", selectedRadix: .decimal),
            RadixConversionSet(inputNumber: "101", selectedRadix: .binary)
        ]
        
        // Act
        let result = elements.containsSet(with: "42", selectedRadix: 10)
        
        // Assert
        XCTAssertTrue(result, "Expected to find a matching element but did not.")
    }
    
    func testContainsSetWithNonMatchingElement() {
        // Arrange
        let elements: [RadixConversionSet] = [
            RadixConversionSet(inputNumber: "42", selectedRadix: .decimal),
            RadixConversionSet(inputNumber: "101", selectedRadix: .binary)
        ]
        
        // Act
        let result = elements.containsSet(with: "99", selectedRadix: 10)
        
        // Assert
        XCTAssertFalse(result, "Expected not to find a matching element but did.")
    }
    
    func testContainsSetWithDifferentRadix() {
        // Arrange
        let elements: [RadixConversionSet] = [
            RadixConversionSet(inputNumber: "42", selectedRadix: .decimal),
            RadixConversionSet(inputNumber: "101", selectedRadix: .binary)
        ]
        
        // Act
        let result = elements.containsSet(with: "42", selectedRadix: 2)
        
        // Assert
        XCTAssertFalse(result, "Expected not to find a matching element with a different radix but did.")
    }
    
    func testContainsSetWithEmptyArray() {
        // Arrange
        let elements: [RadixConversionSet] = []
        
        // Act
        let result = elements.containsSet(with: "42", selectedRadix: 10)
        
        // Assert
        XCTAssertFalse(result, "Expected not to find a matching element in an empty array but did.")
    }
}
