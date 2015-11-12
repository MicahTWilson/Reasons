//
//  PeakView.swift
//  Sydney's App
//
//  Created by Micah Wilson on 11/5/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import UIKit

class PeakView: UIView {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var distance: CGFloat = 0.0
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let previousPoint = touch.previousLocationInView(self)
            let point = touch.locationInView(self)
            
            distance += (point.y - previousPoint.y)
            
            self.transform = CGAffineTransformMakeTranslation(0, distance)
            
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for _ in touches {
            if distance > 150 {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.transform = CGAffineTransformMakeTranslation(0, 500)
                    }, completion: { (finished) -> Void in
                        self.hidden = true
                })
            } else if distance < -150 {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.transform = CGAffineTransformMakeTranslation(0, -500)
                    }, completion: { (finished) -> Void in
                        self.hidden = true
                })
            } else {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.transform = CGAffineTransformMakeTranslation(0, 0)
                })
            }
            self.distance = 0.0
        }
    }
}
