//
//  BucketListIconPicker.swift
//  Sydney's App
//
//  Created by Micah Wilson on 10/31/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import UIKit
import Parse

class BucketListIconPicker: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var iconCollectionView: UICollectionView!
    var parentVC: BucketListViewController!
    var icons: [UIImage] = [
        UIImage(named: "Icon1")!,
        UIImage(named: "Icon2")!,
        UIImage(named: "Icon3")!,
        UIImage(named: "Icon4")!,
        UIImage(named: "Icon5")!,
        UIImage(named: "Icon6")!,
        UIImage(named: "Icon7")!,
        UIImage(named: "Icon8")!,
        UIImage(named: "Icon9")!,
        UIImage(named: "Icon10")!,
        UIImage(named: "Icon11")!,
        UIImage(named: "Icon12")!,
        UIImage(named: "Icon13")!,
        UIImage(named: "Icon14")!,
        UIImage(named: "Icon15")!,
        UIImage(named: "Icon16")!,
        UIImage(named: "Icon17")!,
        UIImage(named: "Icon18")!,
        UIImage(named: "Icon19")!,
        UIImage(named: "Icon20")!,
        UIImage(named: "Icon21")!,
        UIImage(named: "Icon22")!,
        UIImage(named: "Icon23")!,
        UIImage(named: "Icon24")!,
        UIImage(named: "Icon25")!,
        UIImage(named: "Icon26")!,
        UIImage(named: "Icon27")!,
        UIImage(named: "Icon28")!,
        UIImage(named: "Icon29")!,
        UIImage(named: "Icon30")!,
        UIImage(named: "Icon31")!,
        UIImage(named: "Icon32")!,
        UIImage(named: "Icon33")!,
        UIImage(named: "Icon34")!,
        UIImage(named: "Icon35")!,
        UIImage(named: "Icon36")!,
        UIImage(named: "Icon37")!,
        UIImage(named: "Icon38")!,
        UIImage(named: "Icon39")!,
        UIImage(named: "Icon40")!,
        UIImage(named: "Icon41")!,
        UIImage(named: "Icon42")!,
        UIImage(named: "Icon43")!,
        UIImage(named: "Icon44")!,
        UIImage(named: "Icon45")!,
        UIImage(named: "AddIcon")!]
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count-1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("iconPIckerCell", forIndexPath: indexPath) as! IconPickerCell
        cell.imageView.image = icons[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = parentVC.listCollectionView.cellForItemAtIndexPath(NSIndexPath(forItem: self.tag, inSection: 0)) as! BucketListCollectionViewCell
        cell.iconView.setImage(icons[indexPath.row], forState: .Normal)
        parentVC.dismissIconPicker()
        parentVC.saveIcon(self.tag, icon: indexPath.row)
    }
}
