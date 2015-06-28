//
//  currencyTbC.swift
//  cryptoCurrency
//
//  Created by Paweł Charatonik   on 31.01.2015.
//  Copyright (c) 2015 Charatonik. All rights reserved.
//

import UIKit

class CurrencyTbC: UITableViewCell {

    @IBOutlet weak var currencyShort: UILabel!
    @IBOutlet weak var currencyAmount: UILabel!
    @IBOutlet weak var currencyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated)
    }
}
