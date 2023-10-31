//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by Simran Preet Singh Narang on 2023-10-31.
//

import XCTest
@testable import Bankey

final class CurrencyFormatterTests: XCTestCase {
    
    var formatter: CurrencyFormatter!

    override func setUpWithError() throws {
        formatter = CurrencyFormatter()
    }
    
    func testBreakDollarIntoCents() {
        let result = formatter.breakIntoDollarsAndCents(56.23)
        XCTAssertEqual(result.0, "56")
        XCTAssertEqual(result.1, "23")
    }
    
    func testDollarsFormatted() {
        let result = formatter.dollarsFormatted(56.32)
        XCTAssertEqual(result, "$56.32")
    }
    
    func testZeroDollarsFormatted() {
        let result = formatter.dollarsFormatted(0)
        XCTAssertEqual(result, "$0.00")
    }

    override func tearDownWithError() throws {
        
    }
}
