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
}
