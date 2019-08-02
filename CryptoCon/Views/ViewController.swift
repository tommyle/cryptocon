//
//  ViewController.swift
//  CryptoCon
//
//  Created by Tommy Le on 2019-08-02.
//  Copyright © 2019 Tommy Le. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var rates: [Rate] = [Rate]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(RatesTableViewCell.nib, forCellReuseIdentifier: RatesTableViewCell.identifier)

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.loadRates()
    }

    private func loadRates() {
        RatesApi.shared.getRates() { (rateData: RateData?, errorMessage: String?) in
            guard let rateData = rateData else {
                print(errorMessage ?? "Unknown error")
                return
            }

            self.setRates(rateData: rateData)

            self.tableView.reloadData()
        }
    }

    private func setRates(rateData: RateData) {
        self.rates.removeAll()

        for (key, value) in rateData.rates {
            let rate = Rate(name: key, rate: value.rate, high: value.high, low: value.low, vol: value.vol, cap: value.cap, sup: value.sup, change: value.change, change_pct: value.change_pct)
            self.rates.append(rate)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RatesTableViewCell.identifier) as? RatesTableViewCell else {
            return UITableViewCell()
        }

        let rate = self.rates[indexPath.row]

        cell.nameLabel.text = rate.name ?? "Unknown"
        cell.priceLabel.text = "\(rate.rate ?? 0.0)"
        cell.priceDeltaLabel.text = "\(rate.change_pct ?? 0.0)"
        cell.marketCapLabel.text = "\(rate.cap ?? 0.0)"
//        cell.marketCapDeltaLabel.text = "\(rate.change_pct ?? 0.0)"

        return cell
    }
}

