//
//  Rates.swift
//  CryptoConTests
//
//  Created by Tommy Le on 2019-08-03.
//  Copyright © 2019 Tommy Le. All rights reserved.
//

import XCTest
@testable import CryptoCon

class Rates: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    let ratesDataJson = Data("""
            {
                "success":true,
                "timestamp":1564846566,
                "target":"USD",
                "rates":{
                    "ABC":{
                        "rate":59.99,
                        "high":59.99,
                        "low":59.99,
                        "vol":null,
                        "cap":null,
                        "sup":null,
                        "change":0,
                        "change_pct":0
                    },
                    "ACP":{
                        "rate":0.014931,
                        "high":0.014931,
                        "low":0.014931,
                        "vol":null,
                        "cap":null,
                        "sup":null,
                        "change":0,
                        "change_pct":0
                    },
                }
            }
        """.utf8)

    let rateJson = Data("""
            {
                "rate": 10812.083344,
                "high": 11087.7,
                "low": 10332.2,
                "vol": 16953953583.6,
                "cap": 193051910523.91885,
                "sup": 17855200.00001203,
                "change": 271.62743500000033,
                "change_pct": 2.5769989205881543
            }
            """.utf8)

    func testRateDataParsing() {
        do {
            let newRates = try JSONDecoder().decode(RateData.self, from: ratesDataJson)
            XCTAssertEqual(newRates.timestamp, 1564846566)
            XCTAssertEqual(newRates.success, true)
            XCTAssertEqual(newRates.rates.count, 2)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testGetChangePctFormatted() {
        do {
            let rateData = try JSONDecoder().decode(Rate.self, from: rateJson)

            let rate = Rate(name: "bct", rate: rateData)
            XCTAssertEqual(rate.getChangePctFormatted(), "▲ 2.58%")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
