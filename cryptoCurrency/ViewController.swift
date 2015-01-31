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
   
    var currTable = valueTable()
    
    @IBAction func donePressed(sender: AnyObject) {
        
        amountField.resignFirstResponder()
        self.tableView.reloadData()
    }
    
  
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Register custom xell
        var nib = UINib(nibName:"currencyCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")

    }
    
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
            return UITableViewCellEditingStyle.Delete    // fix the editingStyle bug

    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currTable.currencies.count
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: currencyTbC  = tableView.dequeueReusableCellWithIdentifier("cell") as currencyTbC

        cell.currencyImage?.image = UIImage(named:"bitcoin")
        cell.currencyShort?.text = currTable.currencies[indexPath.row].slug
        
        if let cost = currTable.currencies[indexPath.row].value
        {
            var costt = (amountField.text as NSString).doubleValue / cost

            cell.currencyAmount.text = "\(costt)"
        }
        else {cell.currencyAmount.text = amountField.text}
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete
        {
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            currTable.currencies.removeAtIndex(indexPath.row)
            // The delete button doas not show up.. yet
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

 