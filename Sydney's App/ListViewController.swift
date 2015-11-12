//
//  ListViewController.swift
//  Sydney's App
//
//  Created by Micah Wilson on 11/1/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import UIKit
import Parse

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var table: UITableView!
    var items:[String]?
    var itemsProgress:[Bool]?
    var id: String!
    var pfObject: PFObject!
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if items == nil {
            self.items = [String]()
            self.itemsProgress = [Bool]()
        }
        titleLabel.text = name
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items!.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell") as! ItemTableCell
        cell.titleTextField.text = items![indexPath.row]
        cell.titleTextField.tag = indexPath.row
        cell.checkedButton.tag = indexPath.row
        if itemsProgress![indexPath.row] == true {
            checkedPressed(cell.checkedButton)
        }
        
        if items![indexPath.row] == "new" {
            cell.titleTextField.enabled = true
            cell.titleTextField.becomeFirstResponder()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ItemTableCell
        checkedPressed(cell.checkedButton)
    }
    
    @IBAction func addItemPressed(sender: UIButton) {
        items!.insert("new", atIndex: 0)
        itemsProgress!.insert(false, atIndex: 0)
        table.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Top)
    }
    
    @IBAction func backPressed(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func editPressed(sender: UIButton) {
        
    }
    
    @IBAction func checkedPressed(sender: UIButton) {
        if sender.backgroundImageForState(.Normal)! == UIImage(named: "ItemIcon") {
            sender.setBackgroundImage(UIImage(named: "CheckedItemIcon"), forState: .Normal)
            itemsProgress![sender.tag] = true
        } else {
            sender.setBackgroundImage(UIImage(named: "ItemIcon"), forState: .Normal)
            itemsProgress![sender.tag] = false
        }
        pfObject.setValue(items!, forKey: "items")
        pfObject.setValue(itemsProgress!, forKey: "itemsProgress")
        pfObject.saveInBackground()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.enabled = false
        items![textField.tag] = textField.text!
        pfObject.setValue(items!, forKey: "items")
        pfObject.setValue(itemsProgress!, forKey: "itemsProgress")
        pfObject.saveInBackground()
        
        return true
    }
}