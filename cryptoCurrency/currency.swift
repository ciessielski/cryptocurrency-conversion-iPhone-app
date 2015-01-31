//
//  currency.swift
//  cryptoCurrency
//
//  Created by Pumpkin K on 31.01.2015.
//  Copyright (c) 2015 charatonik. All rights reserved.
//

import Foundation
import UIKit

class currency

{
    var name: String?
    var value: Double?
    var image: UIImage?
    let slug: String
    
    //Will probably change after adding the API
    
    init(slug: String)
    {
        self.slug = slug
    }


}