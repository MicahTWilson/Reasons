//
//  BucketListViewController.swift
//  Sydney's App
//
//  Created by Micah Wilson on 10/31/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import UIKit
import Parse

class BucketListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var iconPickerView: BucketListIconPicker!
    var bucketLists:[BucketList] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        iconPickerView.transform = CGAffineTransformMakeTranslation(0, iconPickerView.frame.height + 50)
        iconPickerView.parentVC = self
        iconPickerView.layer.shadowColor = UIColor.darkGrayColor().CGColor
        iconPickerView.layer.shadowOffset = CGSizeMake(0, -2)
        iconPickerView.layer.shadowRadius = 2
        iconPickerView.layer.shadowOpacity = 0.5
        iconPickerView.layer.masksToBounds = false
        
        let query = PFQuery(className:"BucketList")
        var lists = [PFObject]()
        do {
            try lists = query.findObjects()
        } catch {
            print(error)
        }
        
        for list in lists {
            let newBucketList = BucketList(title: list.valueForKey("title") as! String)
            newBucketList.icon = iconPickerView.icons[list.valueForKey("icon") as! Int]
            newBucketList.list = list.valueForKey("items") as? [String]
            newBucketList.listProgress = list.valueForKey("itemsProgress") as? [Bool]
            newBucketList.id = list.objectId!
            newBucketList.pfObject = list
            bucketLists.append(newBucketList)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        bucketLists = [BucketList]()
        let query = PFQuery(className:"BucketList")
        var lists = [PFObject]()
        do {
            try lists = query.findObjects()
        } catch {
            print(error)
        }
        
        for list in lists {
            let newBucketList = BucketList(title: list.valueForKey("title") as! String)
            newBucketList.icon = iconPickerView.icons[list.valueForKey("icon") as! Int]
            newBucketList.list = list.valueForKey("items") as? [String]
            newBucketList.listProgress = list.valueForKey("itemsProgress") as? [Bool]
            newBucketList.id = list.objectId!
            newBucketList.pfObject = list
            bucketLists.append(newBucketList)
        }
        listCollectionView.reloadData()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bucketLists.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("bucketListCell", forIndexPath: indexPath) as! BucketListCollectionViewCell
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 8
        cell.titleLabel.tag = indexPath.row
        cell.iconView.tag = indexPath.row
        cell.iconView.setImage(bucketLists[indexPath.row].icon, forState: .Normal)
        if bucketLists[indexPath.row].title == "new" {
            cell.titleLabel.enabled = true
            cell.titleLabel.becomeFirstResponder()
        } else {
            cell.titleLabel.enabled = false
            cell.titleLabel.text = bucketLists[indexPath.row].title
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let listVC = storyboard?.instantiateViewControllerWithIdentifier("listVC") as! ListViewController
        listVC.items = bucketLists[indexPath.row].list
        listVC.itemsProgress = bucketLists[indexPath.row].listProgress
        listVC.pfObject = bucketLists[indexPath.row].pfObject
        listVC.name = bucketLists[indexPath.row].title
        self.navigationController?.pushViewController(listVC, animated: true)
    }
    
    @IBAction func addBucketList(sender: UIButton) {
        
        bucketLists.insert(BucketList(title: "new"), atIndex: 0)
        bucketLists[0].icon = iconPickerView.icons[45]
        listCollectionView.insertItemsAtIndexPaths([NSIndexPath(forItem: 0, inSection: 0)])
    }
    
    @IBAction func addIconToList(sender: UIButton) {
        //let cell = listCollectionView.cellForItemAtIndexPath(NSIndexPath(forItem: sender.tag, inSection: 0)) as! BucketListCollectionViewCell
        //self.textFieldShouldReturn(cell.titleLabel)
        showIconPicker(sender.tag)
    }
    
    @IBAction func dismissPickerView(sender: UIButton) {
        dismissIconPicker()
    }
    
    func saveIcon(index: Int, icon: Int) {
        bucketLists[index].pfObject.setValue(NSNumber(integer: icon), forKey: "icon")
        bucketLists[index].pfObject.saveInBackground()
    }
    
    func showIconPicker(index: Int) {
        self.iconPickerView.iconCollectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: .Top, animated: false)
        UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .CurveEaseInOut, animations: { () -> Void in
            self.iconPickerView.tag = index
            self.iconPickerView.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
    }
    
    func dismissIconPicker() {
        UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .CurveEaseInOut, animations: { () -> Void in
            self.iconPickerView.transform = CGAffineTransformMakeTranslation(0, self.iconPickerView.frame.height + 50)
            }, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.enabled = false
        if textField.text == "" {
            //No data delete row
            bucketLists.removeAtIndex(textField.tag)
            listCollectionView.deleteItemsAtIndexPaths([NSIndexPath(forItem: textField.tag, inSection: 0)])
        } else {
            let newList = PFObject(className: "BucketList")
            newList.setValue(textField.text!, forKey: "title")
            newList.setValue(45, forKey: "icon")
            let pfACL = PFACL()
            pfACL.setPublicWriteAccess(true)
            pfACL.setPublicReadAccess(true)
            newList.ACL = pfACL
            try! newList.save()
            bucketLists[textField.tag].id = newList.objectId!
            bucketLists[textField.tag].pfObject = newList
            bucketLists[textField.tag].title = textField.text!
        }
        
        return true
    }
}