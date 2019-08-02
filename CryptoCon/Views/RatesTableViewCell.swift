//
//  RatesTableViewCell.swift
//  CryptoCon
//
//  Created by Tommy Le on 2019-08-02.
//  Copyright © 2019 Tommy Le. All rights reserved.
//

import UIKit

class RatesTableViewCell: UITableViewCell {

    static let identifier: String = "RatesTableViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceDeltaLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var marketCapDeltaLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(rate: Rate) {
        self.nameLabel.text = rate.name ?? "Unknown"
        self.priceLabel.text = "$\(rate.rate ?? 0.0)"
        self.priceDeltaLabel.text = "\(rate.change_pct ?? 0.0)"
        self.marketCapLabel.text = "$\(rate.cap ?? 0.0)"
//        self.marketCapDeltaLabel.text = "$\(rate.change_pct ?? 0.0)"

        if let name = rate.name {
            let image = UIImage(named: name.lowercased())
            if (image == nil) {
                self.logoImage.image = UIImage(named: "strat")
            }
            else {
                self.logoImage.image = image
            }
        }
    }
}
