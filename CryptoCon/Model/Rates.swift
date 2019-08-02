//
//  Rates.swift
//  CryptoCon
//
//  Created by Tommy Le on 2019-08-02.
//  Copyright © 2019 Tommy Le. All rights reserved.
//

import UIKit

struct RateData: Decodable {
    let rates: [String: Rate]
    let target: String
    let timestamp: Int
    let success: Bool
}

struct Rate: Decodable {
    let name: String?
    let rate: Float?
    let high: Float?
    let low: Float?
    let vol: Float?
    let cap: Float?
    let sup: Float?
    let change: Float?
    let change_pct: Float?
}
