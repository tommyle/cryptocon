//
//  RatesAPI.swift
//  CryptoCon
//
//  Created by Tommy Le on 2019-08-02.
//  Copyright © 2019 Tommy Le. All rights reserved.
//

import UIKit

class RatesApi {

    static let shared = RatesApi()

    // It either returns the rates or the error message
    typealias QueryResult = (RateData?, String?) -> Void

    func getRates(completion: @escaping QueryResult) {
        let url = URL(string:  "http://api.coinlayer.com/api/live?access_key=d4605c54c3d0e4012b7ec4dd1146a632")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                guard let data = data else { return }

                let newRates = try JSONDecoder().decode(RateData.self, from: data)

                DispatchQueue.main.async {
                    completion(newRates, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, "Error geting rates")
                }
            }
        })

        task.resume()
    }
}
