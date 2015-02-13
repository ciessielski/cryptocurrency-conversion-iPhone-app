//
//  currencyTbC.swift
//  cryptoCurrency
//
//  Created by Paweł Charatonik   on 31.01.2015.
//  Copyright (c) 2015 Charatonik. All rights reserved.
//

import UIKit

class currencyTbC: UITableViewCell {

    

    @IBOutlet weak var currencyShort: UILabel!
    @IBOutlet weak var currencyAmount: UILabel!
    @IBOutlet weak var currencyImage: UIImageView!
    
    @IBAction func currencyButtonPressed(sender: AnyObject)
    
    {
        println("button pressed")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
