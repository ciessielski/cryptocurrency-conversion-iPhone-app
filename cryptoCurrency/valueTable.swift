//
//  valueTable.swift
//  cryptoCurrency
//
//  Created by Paweł Charatonik on 31.01.2015.
//  Copyright (c) 2015 charatonik. All rights reserved.
//

import Foundation
import UIKit

var currencyDictionary =
    [ "USD"     : "Dollar"
    , "EUR"     : "Euro"
    , "GBP"     : "Pound"
    , "BTC"     : "Bitcoin"
    , "XRP"     : "Ripple"
    , "LTC"     : "Litecoin"
    , "BTS"     : "BitShares"
    , "XPY"     : "PayCoin"
    , "STR"     : "Stellar"
    , "DOGE"    : "DogeCoin"
    , "MAID"    : "MaidSafeCoin"
    , "NXT"     : "Nxt"
    , "DRK"     : "Darkcoin"]



class valueTable
{
    var currencies: Array<currency> = []
    var cryptoCurrencies: Array<currency> = []
    
    init()
    {
        currencies.append(currency(slug: "USD", value: 1.0))
        currencies.append(currency(slug: "EUR", value: 1.13))
        currencies.append(currency(slug: "GBP", value: 1.51))
        
        
        cryptoCurrencies.append(currency(slug: "BTC", value:219.13 ))
        cryptoCurrencies.append(currency(slug: "XRP", value:0.0138))
        cryptoCurrencies.append(currency(slug: "LTC", value: 1.75))
        cryptoCurrencies.append(currency(slug: "BTS", value:0.010232))
        cryptoCurrencies.append(currency(slug: "XPY", value:1.79))
        cryptoCurrencies.append(currency(slug: "STR", value:0.004099))
        cryptoCurrencies.append(currency(slug: "DOGE", value:0.000139))
        cryptoCurrencies.append(currency(slug: "MAID", value:0.030681))
        cryptoCurrencies.append(currency(slug: "NXT", value:0.011446))
        cryptoCurrencies.append(currency(slug: "DRK", value:1.70))
        assignAttributes()
    }
    
    
    func getJson(){
    
    
    }
    
    
    func assignAttributes()
    {
        for curr in currencies
        {
            curr.name = currencyDictionary[curr.slug]
            curr.image = UIImage(named: curr.name!)
        }
        
        
        for curr in cryptoCurrencies
        {
            curr.name = currencyDictionary[curr.slug]
            curr.image = UIImage(named: curr.name!)
        }
    }
    
    func reset()
    {

    }

}