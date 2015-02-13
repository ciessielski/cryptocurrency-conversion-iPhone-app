//
//  valueTable.swift
//  cryptoCurrency
//
//  Created by Paweł Charatonik on 31.01.2015.
//  Copyright (c) 2015 charatonik. All rights reserved.
//

import Foundation
import UIKit

let tURL = "http://api.cryptocoincharts.info/tradingPair/"
var data = NSString()

var currencyDictionary =
    [ "usd"     : "Dollar"
    , "eur"     : "Euro"
    , "gbp"     : "Pound"
    , "btc"     : "Bitcoin"
    , "xrp"     : "Ripple"
    , "ltc"     : "Litecoin"
    , "bts"     : "BitShares"
    , "xpy"     : "PayCoin"
    , "str"     : "Stellar"
    , "doge"    : "DogeCoin"
    , "maid"    : "MaidSafeCoin"
    , "nxt"     : "Nxt"
    , "drk"     : "Darkcoin"]

var valueDictionary = [NSString:Double]()

class valueTable
{
    var currencies: Array<currency> = []
    var cryptoCurrencies: Array<currency> = []
    
    init()
    {
        currencies.append(currency(slug: "usd"))
        currencies.append(currency(slug: "eur"))
        currencies.append(currency(slug: "gbp"))
        
        
        cryptoCurrencies.append(currency(slug: "btc"))
        cryptoCurrencies.append(currency(slug: "xrp"))
        cryptoCurrencies.append(currency(slug: "ltc"))
        cryptoCurrencies.append(currency(slug: "bts"))
        cryptoCurrencies.append(currency(slug: "xpy"))
        cryptoCurrencies.append(currency(slug: "str"))
        cryptoCurrencies.append(currency(slug: "doge"))
        cryptoCurrencies.append(currency(slug: "maid"))
        cryptoCurrencies.append(currency(slug: "nxt"))
        cryptoCurrencies.append(currency(slug: "drk"))
        assignAttributes()
    }
    

    func getJson(){
        
        
        valueDictionary["btc"] = 1.0
        cryptoCurrencies[0].value = 1.0
        for cur  in cryptoCurrencies
        {
            if cur.slug != "btc"{
            var kURL = tURL
            
            kURL += ("[\(cur.slug)_btc]")
            println(kURL)
            
            
            let URLrequest = NSURLRequest(URL: NSURL(string: kURL)!)
            var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
            var jsonSource: NSData = NSURLConnection.sendSynchronousRequest(URLrequest, returningResponse: response, error: nil)!
            
            
            data = (NSJSONSerialization.JSONObjectWithData(jsonSource, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary)["price"] as NSString
            
            println(1/data.doubleValue)
            
            cur.value = 1/(data.doubleValue)
            valueDictionary[cur.slug] = 1/(data.doubleValue)
            }
            
        }

        
        for cur  in currencies
        {
                var kURL = tURL
                
                kURL += ("[btc_\(cur.slug)]")
                println(kURL)
                
                
                let URLrequest = NSURLRequest(URL: NSURL(string: kURL)!)
                var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
                var jsonSource: NSData = NSURLConnection.sendSynchronousRequest(URLrequest, returningResponse: response, error: nil)!
                
                
                data = (NSJSONSerialization.JSONObjectWithData(jsonSource, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary)["price"] as NSString
                
                println(data.doubleValue)
            
                cur.value = 1/(data.doubleValue)
                valueDictionary[cur.slug] = (data.doubleValue)
            }
        println(valueDictionary)
        
        
        
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