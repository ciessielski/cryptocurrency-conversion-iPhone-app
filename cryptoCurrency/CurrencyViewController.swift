//
//  ViewController.swift
//  cryptoCurrency
//
//  Created by Paweł Charatonik on 31.01.2015.
//  Copyright (c) 2015 Charatonik. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var amountField:UITextField!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var curImage:UIImageView!
    @IBOutlet weak var currLabel:UILabel!
    var refreshControl :UIRefreshControl!

    var tempval    = 1.0  // current exchange rate to bitcoin
    var currTable  = ValueTable()
    
    // MARK: ViewController Life cycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.view.backgroundColor = UIColor (red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1.0)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newData:", name: "ReceivedData", object: nil)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        var nib = UINib(nibName:"CurrencyCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        refresh(self)
    }

    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func donePressed(sender: AnyObject){
        amountField.resignFirstResponder()
        self.tableView.reloadData()
    }
    
    func refresh(sender:AnyObject){
        if Reachability.isConnectedToNetwork(){
            self.currTable.getJson()
            currLabel.text?.lowercaseString
        }
        else{
            var alert : UIAlertView = UIAlertView(title: "No internet connection", message: "Check your internet connection and try again later", delegate: nil, cancelButtonTitle: "Ok")
                alert.show()
            self.refreshControl.endRefreshing()
        }
    }
    
    func newData(object: AnyObject){
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    // MARK: tableView Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch (indexPath.section){
        case 0,1:
            var tempTable :[Currency]
            if indexPath.section == 0{tempTable = currTable.currencies}
            else{ tempTable = currTable.cryptoCurrencies}
            
            currLabel.text = tempTable[indexPath.row].slug.uppercaseString
            curImage.image = UIImage(named: "\(tempTable[indexPath.row].name!)1")
            
            if let vall = tempTable[indexPath.row].value{
                tempval = vall
            }
            self.tableView.reloadData()
        default: return
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 72
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! HeaderCell
        
        switch (section){
        case 0:
            headerCell.headerLabel.text = "FIAT CURRENCIES";
        case 1:
            headerCell.headerLabel.text = "CRYPTOCURRENCIES";
        default:
            headerCell.headerLabel.text = "Other";
        }
        return headerCell
    }

    // MARK: tableView Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        // section 0 for fiat, section 1 for cryptocurrencies
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        switch (section){
        case  0: return currTable.currencies.count
        case  1: return currTable.cryptoCurrencies.count
        default: return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell: CurrencyTbC  = tableView.dequeueReusableCellWithIdentifier("cell") as! CurrencyTbC

        switch (indexPath.section){
            case 0,1:
                var tempTable :[Currency]
                if indexPath.section == 0{tempTable = currTable.currencies}
                else{ tempTable = currTable.cryptoCurrencies}
                cell.currencyShort?.text = tempTable[indexPath.row].slug.uppercaseString
                if let cost = currTable.valueDictionary[tempTable[indexPath.row].slug]{
                    var costt = ((amountField.text as NSString).doubleValue / tempval) * cost //temp rate
                    cell.currencyAmount.text = String(format: tempTable[indexPath.row].format!, costt)
                }
                else {cell.currencyAmount.text = "⎯"}
                if let im = tempTable[indexPath.row].image{
                    cell.currencyImage.image = im
                }
                return cell
            default: return cell
        }
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return false
    }
}
 