//
//  ViewController.swift
//  cryptoCurrency
//
//  Created by Paweł Charatonik on 31.01.2015.
//  Copyright (c) 2015 Charatonik. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var amountField: UITextField!
    @IBOutlet      var tableView:   UITableView!
    @IBOutlet weak var curImage:    UIImageView!
    @IBOutlet weak var currLabel:   UILabel!
    var                refreshControl:UIRefreshControl!

    var tempval    = 1.0
    var currTable  = valueTable()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor (red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1.0)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newData:", name: "ReceivedData", object: nil)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        var nib = UINib(nibName:"currencyCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        refresh(self)
    }
    
    @IBAction func donePressed(sender: AnyObject)
    {
        amountField.resignFirstResponder()
        self.tableView.reloadData()
    }
    
    func refresh(sender:AnyObject)
    {
        if Reachability.isConnectedToNetwork()
        {
            self.currTable.getJson()
            currLabel.text?.lowercaseString
            // here is the place to fix my buggie
        }
            
        else
        {
            var alert : UIAlertView = UIAlertView(title: "No internet connection", message: "Check your internet connection and try again later", delegate: nil, cancelButtonTitle: "Ok")
                alert.show()
            self.refreshControl.endRefreshing()
        }
    }
    
    func newData(object: AnyObject)
    {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // section 0 for fiat, section 1 for cryptocurrencies
        return 2
    }
    
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle
    {
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 72
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch (section)
        {
            case  0: return currTable.currencies.count
            case  1: return currTable.cryptoCurrencies.count
            default: return 1
        }
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell: currencyTbC  = tableView.dequeueReusableCellWithIdentifier("cell") as! currencyTbC

        switch (indexPath.section)
        {
            case 0:
            
                cell.currencyShort?.text = currTable.currencies[indexPath.row].slug.uppercaseString
            
                if let cost = currTable.currencies[indexPath.row].value    //value of the currency
                {
                    var costt = ((amountField.text as NSString).doubleValue / tempval) * cost //temp rate
                    cell.currencyAmount.text = String(format: currTable.currencies[indexPath.row].format!, costt)
                }
                else {cell.currencyAmount.text = "⎯"}
            
            
                if let im = currTable.currencies[indexPath.row].image
                {
                    cell.currencyImage.image = im
                }
                return cell
            
            case 1:
                
                cell.currencyShort?.text = currTable.cryptoCurrencies[indexPath.row].slug.uppercaseString
            
                if let cost = currTable.cryptoCurrencies[indexPath.row].value
                {
                    var costt = ((amountField.text as NSString).doubleValue  / tempval) * cost
                    cell.currencyAmount.text = String(format: currTable.cryptoCurrencies[indexPath.row].format!,costt)
                }
                else {cell.currencyAmount.text = "⎯"}
            
                if let im = currTable.cryptoCurrencies[indexPath.row].image
                {
                    cell.currencyImage.image = im
                }
                return cell

            default: return cell
        }
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! HeaderCell
        
        switch (section)
        {
            case 0:
            
                headerCell.headerLabel.text = "FIAT CURRENCIES";
                //return sectionHeaderView
            case 1:
                headerCell.headerLabel.text = "CRYPTOCURRENCIES";

            default:
                headerCell.headerLabel.text = "Other";
        }
        return headerCell
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return false
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if indexPath.section == 0
        {
            currLabel.text = currTable.currencies[indexPath.row].slug.uppercaseString
            curImage.image = UIImage(named: "\(currTable.currencies[indexPath.row].name!)1")
            
            if let vall = currTable.currencies[indexPath.row].value
            {
               tempval = vall
            }
            self.tableView.reloadData()
        }
        
        if indexPath.section == 1
        {
            currLabel.text = currTable.cryptoCurrencies[indexPath.row].slug.uppercaseString
            curImage.image = UIImage(named: "\(currTable.cryptoCurrencies[indexPath.row].name!)1")
            
            if let vall = currTable.cryptoCurrencies[indexPath.row].value
            {
                tempval = vall
            }
            self.tableView.reloadData()

        }
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

 