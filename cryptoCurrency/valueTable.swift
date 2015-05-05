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
var dataa = NSString()
var dat = NSString()

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
        currencies.append(currency(slug: "usd", format: "%2f"))
        currencies.append(currency(slug: "eur", format: "%2f"))
        currencies.append(currency(slug: "gbp", format: "%2f"))
        
        
        cryptoCurrencies.append(currency(slug: "btc", format: "%.4f"))
        cryptoCurrencies.append(currency(slug: "xrp", format: "%.0f"))
        cryptoCurrencies.append(currency(slug: "ltc", format: "%.3f"))
        cryptoCurrencies.append(currency(slug: "bts", format: "%.0f"))
        cryptoCurrencies.append(currency(slug: "xpy", format: "%.2f"))
        cryptoCurrencies.append(currency(slug: "str", format: "%.0f"))
        cryptoCurrencies.append(currency(slug: "doge", format: "%.0f"))
        cryptoCurrencies.append(currency(slug: "maid", format: "%.1f"))
        cryptoCurrencies.append(currency(slug: "nxt", format: "%.0f"))
        cryptoCurrencies.append(currency(slug: "drk", format: "%.3f"))
        assignAttributes()
    }
    

    func getJson()
    
    {
        valueDictionary["btc"] = 1.0
        cryptoCurrencies[0].value = 1.0
        
            for cur  in currencies
            {
                if cur.slug != "btc"
                {
                    var kURL = tURL
                    kURL += ("[btc_\(cur.slug)]")
                    println(kURL)
            
                    let URLrequest = NSURLRequest(URL: NSURL(string: kURL)!)
                    let queue:NSOperationQueue = NSOperationQueue()
                            NSURLConnection.sendAsynchronousRequest(URLrequest, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                            var err: NSError
                                
                            dataa = (NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary)["price"] as! NSString
                                
                            println("\(cur.slug)   \(dataa)")
                            cur.value = (dataa.doubleValue)
                            valueDictionary[cur.slug] = dataa.doubleValue
                                
                            dispatch_async(dispatch_get_main_queue())
                            {
                                if valueDictionary.count == currencyDictionary.count
                                {
                                    NSNotificationCenter.defaultCenter().postNotificationName("ReceivedData", object: nil)
                                }
                            }
                    })
                }
            }
        

        
        for cur  in cryptoCurrencies
        {
            if cur.slug != "btc"
            {
                var kURL = tURL
                kURL += ("[\(cur.slug)_btc]")
                println(kURL)
                
                let URLrequest = NSURLRequest(URL: NSURL(string: kURL)!)
                let queue:NSOperationQueue = NSOperationQueue()
                        NSURLConnection.sendAsynchronousRequest(URLrequest, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                        var err: NSError
                    
                        var data1: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                        dataa = (NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary)["price"] as! NSString

                        println("\(cur.slug)   \(1/dataa.doubleValue)")
                        cur.value = 1/(dataa.doubleValue)
                        valueDictionary[cur.slug] = 1/(dataa.doubleValue)
                    
                        dispatch_async(dispatch_get_main_queue())
                        {
                            if valueDictionary.count == currencyDictionary.count
                            {
                                println("\(valueDictionary)")
                                NSNotificationCenter.defaultCenter().postNotificationName("ReceivedData", object: nil)
                            }
                        }
                })
            }
        }
    }
    
    
    func assignAttributes()
    {
        for curr in currencies
        {
            curr.name = currencyDictionary[curr.slug]
            curr.image = UIImage(named: curr.name!)
            curr.format = "%.2f"
        }
        
        for curr in cryptoCurrencies
        {
            curr.name = currencyDictionary[curr.slug]
            curr.image = UIImage(named: curr.name!)
        }
        
    }
}











