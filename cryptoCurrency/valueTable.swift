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
        currencies.append(currency(slug: "EUR", value: 0.886))
        currencies.append(currency(slug: "GBP", value: 0.66))
        
        
        cryptoCurrencies.append(currency(slug: "BTC", value: 0.00458439))
        cryptoCurrencies.append(currency(slug: "XRP"))
        cryptoCurrencies.append(currency(slug: "LTC", value: 0.53536))
        cryptoCurrencies.append(currency(slug: "BTS"))
        cryptoCurrencies.append(currency(slug: "XPY"))
        cryptoCurrencies.append(currency(slug: "STR"))
        cryptoCurrencies.append(currency(slug: "DOGE"))
        cryptoCurrencies.append(currency(slug: "MAID"))
        cryptoCurrencies.append(currency(slug: "NXT"))
        cryptoCurrencies.append(currency(slug: "DRK"))
        assignAttributes()
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