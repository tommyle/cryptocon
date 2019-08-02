//
//  Rates.swift
//  CryptoCon
//
//  Created by Tommy Le on 2019-08-02.
//  Copyright © 2019 Tommy Le. All rights reserved.
//

import UIKit

struct RateData: Decodable {
    let rates: [String: Float]
    let target: String
    let timestamp: Int
    let success: Bool
}

class Rate {
    let name: String
    let price: Float

    init(name: String, price: Float) {
        self.name = name
        self.price = price
    }
}
