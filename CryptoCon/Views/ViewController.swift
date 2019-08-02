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
            self.rates.append(Rate(name: key, price: value))
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

        cell.nameLabel.text = self.rates[indexPath.row].name
        cell.priceLabel.text = "\(self.rates[indexPath.row].price)"

        return cell
    }
}

