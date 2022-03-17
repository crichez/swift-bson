//
//  BSONValueTests.swift
//  BSONValueTests
//
//  Created by Christopher Richez on 3/16/22.
//

import BSONKit
import XCTest

/// A test suite for all `ValueProtocol` conforming types.
class BSONValueEncodingTests: XCTestCase {
    func testDouble() throws {
        let value = Double.random(in: .leastNonzeroMagnitude ... .greatestFiniteMagnitude)
        let expectedType: UInt8 = 1
        let expectedBytes = withUnsafeBytes(of: value.bitPattern) { Array($0) }
        XCTAssertEqual(value.bsonType, expectedType)
        XCTAssertEqual(value.bsonBytes, expectedBytes)
    }

    func testString() throws {
        let value = "this is a test! \u{10097}"
        let expectedType: UInt8 = 2
        let expectedBytes = Int32(value.utf8.count + 1).bsonBytes + Array(value.utf8) + [0]
        XCTAssertEqual(value.bsonType, expectedType)
        XCTAssertEqual(value.bsonBytes, expectedBytes)
    }
}
