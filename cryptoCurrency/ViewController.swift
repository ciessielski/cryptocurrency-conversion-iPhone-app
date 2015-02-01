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
   
    var currTable = valueTable()
    
    @IBAction func donePressed(sender: AnyObject) {
        
        amountField.resignFirstResponder()
        self.tableView.reloadData()
    }
    
  
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //Register custom cell
        var nib = UINib(nibName:"currencyCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")

    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // section 0 for fiat and section 2 for cryptocurrencies
        return 2
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle.Delete    // fix the editingStyle bug

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
            
            cell.currencyShort?.text = currTable.currencies[indexPath.row].slug
            
            if let cost = currTable.currencies[indexPath.row].value
            {
                var costt = (amountField.text as NSString).doubleValue * cost
                cell.currencyAmount.text = String(format: "%.2f", costt)
            }
            else {cell.currencyAmount.text = amountField.text}
            
            
            if let im = currTable.currencies[indexPath.row].image
            {
                cell.currencyImage.image = im
            }
            return cell
            
        case 1:
            cell.currencyShort?.text = currTable.cryptoCurrencies[indexPath.row].slug
            if let cost = currTable.cryptoCurrencies[indexPath.row].value
            {
                var costt = (amountField.text as NSString).doubleValue * cost
                cell.currencyAmount.text = String(format: "%.2f", costt)
            }
            else {cell.currencyAmount.text = amountField.text}
            
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
        return true
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete
        {
            // tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            // currTable.currencies.removeAtIndex(indexPath.row)
            // The delete button doas show up but it aint work.. yet
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("row \(indexPath.row) is pressed")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

 