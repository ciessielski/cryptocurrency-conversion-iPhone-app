//
//  valueTable.swift
//  cryptoCurrency
//
//  Created by Pumpkin K on 31.01.2015.
//  Copyright (c) 2015 charatonik. All rights reserved.
//

import Foundation

var currencyDictionary =
    [ "USD"     : "Dollar"
    , "EUR"     : "Euro"
    , "PLN"     : "Złoty"
    , "BTC"     : "Bitcoin"
    , "XRP"     : "Ripple"
    , "LTC"     : "Litecoin"
    , "BTS"     : "BitShares"
    , "XPY"     : "PayCoin"
    , "STR"     : "Stellar"
    , "DOGE"    : "DogeCoin"
    , "MAID"    : "MaidSaveCoin"
    , "NXT"     : "Nxt"
    , "DRK"     : "Darkcoin"]



class valueTable
{
    var currencies: Array<currency> = []
    
    
    init()
    {
        currencies.append(currency(slug: "USD"))
        currencies.append(currency(slug: "EUR"))
        currencies.append(currency(slug: "PLN"))
        currencies.append(currency(slug: "BTC"))
        currencies.append(currency(slug: "XRP"))
        currencies.append(currency(slug: "LTC"))
        currencies.append(currency(slug: "BTS"))
        currencies.append(currency(slug: "XPY"))
        currencies.append(currency(slug: "STR"))
        currencies.append(currency(slug: "DOGE"))
        currencies.append(currency(slug: "MAID"))
        currencies.append(currency(slug: "NXT"))
        currencies.append(currency(slug: "DRK"))
        assignAttributes()
    }
    
    
    func assignAttributes()
    {
        for curr in currencies
        {
            curr.name = currencyDictionary[curr.slug]
        }
    }
    
    func reset()
    {

    }

}