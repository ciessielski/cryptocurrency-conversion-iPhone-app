//
//  currency.swift
//  cryptoCurrency
//
//  Created by Pumpkin K on 31.01.2015.
//  Copyright (c) 2015 charatonik. All rights reserved.
//

import Foundation
import UIKit

class Currency{
    
    var name: String?
    var value: Double?
    var image: UIImage?
    var format: String?
    let slug: String
    
    init(slug: String){
        self.slug = slug
    }
    
    init(slug: String, format: String){
        self.slug = slug
        self.format = format
    }
    
    init(slug: String, value: Double){
        self.slug = slug
        self.value = value
    }
}