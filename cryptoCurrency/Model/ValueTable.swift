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
var jSONData = NSString()

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

class ValueTable{
    
    var valueDictionary :[NSString:Double]{
        get{return defaults.objectForKey(curKey) as? [NSString:Double] ?? [:]}
        set{defaults.setObject(newValue, forKey: curKey)}
    }
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    let curKey = "LatestCurrencyValues.Values"
    var currencies: [Currency] = []
    var cryptoCurrencies: [Currency] = []
    
    init(){
        currencies.append(Currency(slug: "usd", format: "%2f"))
        currencies.append(Currency(slug: "eur", format: "%2f"))
        currencies.append(Currency(slug: "gbp", format: "%2f"))
        
        cryptoCurrencies.append(Currency(slug: "btc",  format: "%.4f"))
        cryptoCurrencies.append(Currency(slug: "xrp",  format: "%.0f"))
        cryptoCurrencies.append(Currency(slug: "ltc",  format: "%.3f"))
        cryptoCurrencies.append(Currency(slug: "bts",  format: "%.0f"))
        cryptoCurrencies.append(Currency(slug: "xpy",  format: "%.2f"))
        cryptoCurrencies.append(Currency(slug: "str",  format: "%.0f"))
        cryptoCurrencies.append(Currency(slug: "doge", format: "%.0f"))
        cryptoCurrencies.append(Currency(slug: "maid", format: "%.1f"))
        cryptoCurrencies.append(Currency(slug: "nxt",  format: "%.0f"))
        cryptoCurrencies.append(Currency(slug: "drk",  format: "%.3f"))
        assignAttributes()
    }

    func getJson(){
        valueDictionary["btc"] = 1.0
        cryptoCurrencies[0].value = 1.0
        
        for cur  in currencies{
            if cur.slug != "btc"{
                var kURL = tURL
                kURL += ("[btc_\(cur.slug)]")
                let URLrequest = NSURLRequest(URL: NSURL(string: kURL)!)
                let queue:NSOperationQueue = NSOperationQueue()
                        NSURLConnection.sendAsynchronousRequest(URLrequest, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                        var err: NSError
                        jSONData = (NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary)["price"] as! NSString
                        cur.value = (jSONData.doubleValue)
                        self.valueDictionary[cur.slug] = jSONData.doubleValue
                        dispatch_async(dispatch_get_main_queue()){
                            if self.valueDictionary.count == currencyDictionary.count{
                                NSNotificationCenter.defaultCenter().postNotificationName("ReceivedData", object: nil)
                            }
                        }
                })
            }
        }
        
        for cur  in cryptoCurrencies
        {
            if cur.slug != "btc"{
                var kURL = tURL
                kURL += ("[\(cur.slug)_btc]")
                println(kURL)
                let URLrequest = NSURLRequest(URL: NSURL(string: kURL)!)
                let queue:NSOperationQueue = NSOperationQueue()
                        NSURLConnection.sendAsynchronousRequest(URLrequest, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                        var err: NSError
                        jSONData = (NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary)["price"] as! NSString
                        cur.value = 1/(jSONData.doubleValue)
                        self.valueDictionary[cur.slug] = 1/(jSONData.doubleValue)
                        dispatch_async(dispatch_get_main_queue()){
                            if self.valueDictionary.count == currencyDictionary.count{
                                NSNotificationCenter.defaultCenter().postNotificationName("ReceivedData", object: nil)
                            }
                        }
                })
            }
        }
    }
    
    func assignAttributes(){
        for curr in currencies{
            curr.name = currencyDictionary[curr.slug]
            curr.image = UIImage(named: curr.name!)
            curr.format = "%.2f"
        }
        
        for curr in cryptoCurrencies{
            curr.name = currencyDictionary[curr.slug]
            curr.image = UIImage(named: curr.name!)
        }
    }
}











