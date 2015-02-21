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
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var curImage: UIImageView!
    @IBOutlet weak var currLabel: UILabel!
    
    // tempval contains the value of the currency we want to convert
    var tempval = 1.0
    var currTable = valueTable()
    
    @IBAction func donePressed(sender: AnyObject) {
        
        amountField.resignFirstResponder()
        self.tableView.reloadData()
    }
    
  
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dispatch_async(dispatch_get_main_queue())
        {
            self.currTable.getJson()
            self.tableView.reloadData()
        }
        
            var nib = UINib(nibName:"currencyCell", bundle: nil)
            tableView.registerNib(nib, forCellReuseIdentifier: "cell")
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // section 0 for fiat and section 2 for cryptocurrencies
        return 2
    }
    
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle.Delete
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch (section)
        
        {
            case 0: return currTable.currencies.count
            case 1: return currTable.cryptoCurrencies.count
            default: return 1
        
        }
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: currencyTbC  = tableView.dequeueReusableCellWithIdentifier("cell") as currencyTbC

        switch (indexPath.section)
        
        {
        case 0:
            
            cell.currencyShort?.text = currTable.currencies[indexPath.row].slug.uppercaseString
            
            
            if let cost = currTable.currencies[indexPath.row].value    //value of the currency
            {
                var costt = ((amountField.text as NSString).doubleValue / tempval) * cost //temp rate
                cell.currencyAmount.text = String(format: "%.2f", costt)
            }
            else {cell.currencyAmount.text = "-"}
            
            
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
                    cell.currencyAmount.text = String(format: "%.4f",costt)

            }
            else {cell.currencyAmount.text = "-"}
            
            if let im = currTable.cryptoCurrencies[indexPath.row].image
            {
                cell.currencyImage.image = im
            }
            else {
            }
        
            return cell

            
        default: return cell
            
        }
        
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as HeaderCell
        
        switch (section) {
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
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete
        {}  // no editing commitment in this version
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if indexPath.section == 0
        {
            currLabel.text = currTable.currencies[indexPath.row].slug.uppercaseString
            curImage.image = UIImage(named: "\(currTable.currencies[indexPath.row].name!)1")
            tempval = currTable.currencies[indexPath.row].value!
            self.tableView.reloadData()
        
        }
        
        if indexPath.section == 1
        {
            currLabel.text = currTable.cryptoCurrencies[indexPath.row].slug.uppercaseString
            curImage.image = UIImage(named: "\(currTable.cryptoCurrencies[indexPath.row].name!)1")
            tempval = currTable.cryptoCurrencies[indexPath.row].value!
            self.tableView.reloadData()

            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

 