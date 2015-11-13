//
//  StoryViewController.swift
//  Sydney's App
//
//  Created by Micah Wilson on 11/1/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var leftWeMeet: UIImageView!
    @IBOutlet weak var rightWeMeet: UIImageView!
    @IBOutlet weak var leftWeMeetPath: UIImageView!
    @IBOutlet weak var rightWeMeetPath: UIImageView!
    @IBOutlet weak var leftWeMeetLabel: UILabel!
    @IBOutlet weak var rightWeMeetLabel: UILabel!
    @IBOutlet weak var continuingPath: UIImageView!
    @IBOutlet var cloudIcons: [UIImageView]!
    @IBOutlet var imageIcons: [UIImageView]!
    @IBOutlet weak var peakView: PeakView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSizeMake(self.view.frame.width, 4900)
        peakView.hidden = true
        peakView.clipsToBounds = false
        peakView.layer.shadowColor = UIColor.blackColor().CGColor
        peakView.layer.shadowOpacity = 0.2
        peakView.layer.shadowOffset = CGSizeMake(0, 0)
        
        for image in imageIcons {
            image.userInteractionEnabled = true
            image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "imageTapped:"))
        }
    }
    
    func imageTapped(sender: UITapGestureRecognizer) {
        //Set up date for the peak view
        peakView.dateLabel.text = getDates()[sender.view!.tag]
        peakView.image.image = (sender.view as! UIImageView).image
        peakView.descriptionLabel.text = getDescriptions()[sender.view!.tag]
        
        //Move the peak view to the center of the senders view.
        //Scale the peak view to senders view size.
        peakView.hidden = false
        let offsetX = (peakView.center.x - sender.view!.center.x) - sender.view!.transform.tx
        let offsetY = (peakView.center.y - sender.view!.center.y - 70) + scrollView.contentOffset.y
        let translateTransform = CGAffineTransformMakeTranslation(-offsetX, -offsetY)
        let scale = 100 / peakView.frame.width
        let shrinkTransform = CGAffineTransformMakeScale(scale, scale)
        peakView.transform = CGAffineTransformConcat(shrinkTransform, translateTransform)
        
        UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .CurveEaseInOut, animations: { () -> Void in
            self.peakView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1), CGAffineTransformMakeTranslation(0, 0))
            }, completion: nil)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        for cloud in cloudIcons {
            cloud.transform = CGAffineTransformMakeTranslation(0,-offset/8)
        }
        
        if offset > 1100 && offset < 3000 {
            let distanceBetween = rightWeMeet.center.x - leftWeMeet.center.x
            let distanceOffset = offset - 1100
            
            if distanceOffset < distanceBetween/2 {
                leftWeMeet.transform = CGAffineTransformMakeTranslation(distanceOffset, 0)
                rightWeMeet.transform = CGAffineTransformMakeTranslation(-distanceOffset, 0)
                leftWeMeetLabel.transform = CGAffineTransformMakeTranslation(distanceOffset, 0)
                rightWeMeetLabel.transform = CGAffineTransformMakeTranslation(-distanceOffset, 0)
                
                //Rotate path
                leftWeMeetPath.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation((-distanceOffset*CGFloat(M_1_PI)/180)*2), CGAffineTransformMakeTranslation(distanceOffset/3, 0))
                rightWeMeetPath.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation((distanceOffset*CGFloat(M_1_PI)/180)*2), CGAffineTransformMakeTranslation(-distanceOffset/3, 0))
                
                continuingPath.alpha = distanceOffset/(distanceBetween/2)
            } else {
                leftWeMeet.transform = CGAffineTransformMakeTranslation(distanceBetween/2, 0)
                rightWeMeet.transform = CGAffineTransformMakeTranslation(-distanceBetween/2, 0)
                leftWeMeetLabel.transform = CGAffineTransformMakeTranslation(distanceBetween/2, 0)
                rightWeMeetLabel.transform = CGAffineTransformMakeTranslation(-distanceBetween/2, 0)
                leftWeMeetPath.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation((-distanceBetween/2*CGFloat(M_1_PI)/180)*2), CGAffineTransformMakeTranslation(distanceBetween/6, 0))
                rightWeMeetPath.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation((distanceBetween/2*CGFloat(M_1_PI)/180)*2), CGAffineTransformMakeTranslation(-distanceBetween/6, 0))
            }
        } else if offset < 1100 {
            leftWeMeet.transform = CGAffineTransformMakeTranslation(0, 0)
            rightWeMeet.transform = CGAffineTransformMakeTranslation(0, 0)
            leftWeMeetLabel.transform = CGAffineTransformMakeTranslation(0, 0)
            rightWeMeetLabel.transform = CGAffineTransformMakeTranslation(0, 0)
            
            //Rotate path
            leftWeMeetPath.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation((0*CGFloat(M_1_PI)/180)*2), CGAffineTransformMakeTranslation(0/3, 0))
            rightWeMeetPath.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation((0*CGFloat(M_1_PI)/180)*2), CGAffineTransformMakeTranslation(0/3, 0))
        }
    }
    
}

extension StoryViewController {
    func getDates() -> [String] {
        return ["November 19th, 1993","January 25th, 1994","November 24th, 2001","February 2nd, 2002","April 27th, 2013","November 23rd, 2012","June 5th, 2013","January 16th, 2013","December 18th, 2014","December 16th, 2014","February 13th, 2015","February 15th, 2015", "May 14th, 2015", "June 7th, 2015", "June 12th, 2015", "June 12th 2015", "June 13th 2015", "June 13th 2015", "June 26th 2015", "June 28th, 2015", "July 3rd, 2015", "July 4th 2015", "July 21st, 2015", "July 25th, 2015", "August 1st, 2015", "August 10th, 2015", "August 12th, 2015", "September 6th, 2015", "September 17th, 2015", "October 7th, 2015", "November 21st, 2015"]
    }
    
    func getDescriptions() -> [String] {
        return [
            "Sydney's baby picture.",
            "Micah's baby picture.",
            "Sydney's baptism picture.",
            "Micah's baptism picture.",
            "Sydney's endowment picture.",
            "Micah's endowment picture.",
            "Sydney leaving for her mission in Japan.",
            "Micah leaving for his mission in California.",
            "Sydney coming home from her mission in Japan.",
            "Micah coming home from his mission in California.",
            "They meet. The first time Sydney and Micah truly meet. A trip to Vegas for the weekend!",
            "They Flirt. A snapchat from Sydney to Micah.",
            "Micah goes with Sydney to take blood pressure for her CNA class.",
            "They Kiss. Micah kisses Sydney on a mountain overlooking Provo.",
            "They Love. Sydney and Micah take this picture jokingly.",
            "They Date. Sydney and Micah celebrating Kasandra's wedding.",
            "Sydney and Micah take a trip to Hannah's cabin for the weekend.",
            "Micah crashes the four-wheeler into the fence.",
            "Micah sitting in the big chair in beaver on his way to surprise Sydney in St. George.",
            "Micah surprises Sydney as she gets home from Japan.",
            "Sydney and Micah celebrating the 4th of July at Aggie Stadium.",
            "Nothing like a hamburger for the 4th of July.",
            "Micah takes a spontaneous trip to St. George with Sydney for a few days.",
            "Micah asks Sydney to marry him.",
            "Micah drops his phone off a rollercoaster at Lagoon. :(",
            "Sydney and Micah take their first roadtrip.",
            "Sydney and Micah get free Disneyland tickets.",
            "The first family reunion, in Alta Wyoming.",
            "Sydney and Micah take their engagement pictures.",
            "Sydney and Micah take their bridal pictures",
            "Sydney and Micah are married and sealed for all time and eternity."]
    }
}
