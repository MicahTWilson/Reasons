//
//  ReasonsViewController.swift
//  Sydney's App
//
//  Created by Micah Wilson on 10/29/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import UIKit

class ReasonsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 22
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reasonCell = tableView.dequeueReusableCellWithIdentifier("reasonCell") as! ReasonTableCell
        reasonCell.indexLabel.text = "\(indexPath.row + 1)."
        reasonCell.titleLabel.text = ReasonsData.titles[indexPath.row]
        return reasonCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let reasonDetailsVC = storyboard?.instantiateViewControllerWithIdentifier("reasonDetailsVC") as! ReasonDetailsViewController
        self.navigationController?.pushViewController(reasonDetailsVC, animated: true)
        reasonDetailsVC.setContent(ReasonsData.images[indexPath.row], title: ReasonsData.titles[indexPath.row], story: ReasonsData.stories[indexPath.row])
    }
    
    
}

