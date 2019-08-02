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
    @IBOutlet weak var searchBar: UISearchBar!

    var rates: [Rate] = [Rate]()
    var filteredRates: [Rate] = [Rate]()
    var isSearching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(RatesTableViewCell.nib, forCellReuseIdentifier: RatesTableViewCell.identifier)

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self

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

    private func rateResults() -> [Rate] {
        return self.isSearching ? self.filteredRates : self.rates
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rateResults().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RatesTableViewCell.identifier) as? RatesTableViewCell else {
            return UITableViewCell()
        }

        let rate = self.rateResults()[indexPath.row]
        cell.setup(rate: rate)

        return cell
    }
}

extension ViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.isSearching = true

        self.filteredRates = self.rates.filter({rate in
            guard let name = rate.name else { return false }
            return name.lowercased().contains(searchText.lowercased())
        })

        if (searchText.isEmpty) {
            self.isSearching = false
        }

        self.tableView.reloadData()
    }

}
