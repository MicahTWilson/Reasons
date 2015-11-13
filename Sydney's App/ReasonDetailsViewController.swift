//
//  ReasonDetailsViewController.swift
//  Sydney's App
//
//  Created by Micah Wilson on 10/30/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import UIKit

class ReasonDetailsViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerBlurView: UIVisualEffectView!
    @IBOutlet weak var headerView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var storyField: UITextView!
    var image: UIImage!
    var storyTitle: String!
    var story: String!
    lazy var headerTransformDistance: CGFloat = {
        return 132
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set up data
        self.headerView.image = image
        self.titleLabel.text = storyTitle
        self.storyField.text = story
        
        self.headerBlurView.effect = UIBlurEffect(style: .Light)
        self.headerBlurView.alpha = 0
        self.scrollView.contentSize = CGSizeMake(self.view.frame.width, 850)
        
        //Set up story field
        storyField.editable = false
    }
    
    @IBAction func backPressed(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func likePressed(sender: UIButton) {
        if sender.backgroundImageForState(.Normal)! == UIImage(named: "LikeIcon") {
            sender.setBackgroundImage(UIImage(named: "LikedIcon"), forState: .Normal)
        } else {
            sender.setBackgroundImage(UIImage(named: "LikeIcon"), forState: .Normal)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        // Blocks user from scrolling down past 1/2 screen height
        if offset < -self.view.bounds.height * 0.5 {
            scrollView.contentOffset.y = -self.view.bounds.height * 0.5
            return
        }
        // PULL DOWN
        if offset < 0 {
            // Header View Stretch
            var headerTransform = CATransform3DIdentity
            let headerScaleFactor: CGFloat = -(offset) / self.headerView.bounds.height
            let headerSizevariation = ((self.headerView.bounds.height * (1.0 + headerScaleFactor)) - self.headerView.bounds.height) / 2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            self.headerView.layer.transform = headerTransform
            self.titleLabel.transform = CGAffineTransformMakeTranslation(0, -offset)
        } else {
            // SCROLL UP
            // Header View Collapse
            if offset > headerTransformDistance {
                self.headerView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -headerTransformDistance)
            } else {
                self.headerView.transform = CGAffineTransformMakeTranslation(0, -offset)
            }
            
            if offset > headerTransformDistance + 50 {
                self.titleLabel.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -headerTransformDistance - 50)
            } else {
               self.titleLabel.transform = CGAffineTransformMakeTranslation(0, -offset)
            }
        }
        // Header View Blur Alpha
        self.headerBlurView.alpha = (1.5 / headerTransformDistance) * offset - 0.5
        // Update Label Positions/Alphas
        //self.keySkillView.leftTitleLabel.transform = CGAffineTransformMakeTranslation(0, -offset)
        //self.keySkillView.activitiesCompletedLabel.transform = CGAffineTransformMakeTranslation(0, -offset)
        //self.keySkillView.leftTitleLabel.alpha = (-3.0 / headerTransformDistance) * offset + 2
        //self.keySkillView.activitiesCompletedLabel.alpha = self.keySkillView.leftTitleLabel.alpha
        //self.keySkillView.centerTitleLabel.alpha = (3.0 / headerTransformDistance) * offset - 2
        
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: self.headerTransformDistance + 64 - offset, left: 0, bottom: 50, right: 0)
    }
    
    func setContent(image: UIImage, title: String, story: String) {
        self.image = image
        self.storyTitle = title
        self.story = story
    }
}
