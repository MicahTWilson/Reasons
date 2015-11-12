//
//  CountdownViewController.swift
//  Sydney's App
//
//  Created by Micah Wilson on 10/29/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import UIKit

enum TimeLeftState {
    case days
    case weeks
    case months
}

class CountdownViewController: UIViewController {
    @IBOutlet weak var countdownView: UIVisualEffectView!
    @IBOutlet weak var timeLeftLabel: UILabel!
    var weddingDate: NSDate!
    var state: TimeLeftState!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        weddingDate = dateWith(2015, month: 11, day: 21, hour: 23, minute:59)
        state = .days
        updateTimeLabel()
        
        countdownView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "changeState:"))
        
    }
    
    func updateTimeLabel() {
        let date = NSDate()
        var days = weddingDate.timeIntervalSinceDate(date)/(24*60*60)
        var weeks = weddingDate.timeIntervalSinceDate(date)/(7*24*60*60)
        var months = weddingDate.timeIntervalSinceDate(date)/(30*24*60*60)
        
        if state == .days {
            if days < 1 {
                days = 0
            }
            if Int(round(days)) != 1 {
                timeLeftLabel.text = "\(Int(days)) Days Left"
            } else {
                timeLeftLabel.text = "\(Int(days)) Day Left"
            }
        } else if state == .weeks {
            if weeks < 1 {
                weeks = 0
            }
            if Int(round(weeks)) != 1 {
                timeLeftLabel.text = "\(Int(weeks)) Weeks Left"
            } else {
                timeLeftLabel.text = "\(Int(weeks)) Week Left"
            }
        } else {
            if months < 1 {
                months = 0
            }
            if Int(round(months)) != 1 {
                timeLeftLabel.text = "\(Int(months)) Months Left"
            } else {
                timeLeftLabel.text = "\(Int(months)) Month Left"
            }
        }
            
    }

    func changeState(sender: UITapGestureRecognizer) {
        if state == .days {
            state = .weeks
        } else if state == .weeks {
            state = .months
        } else {
            state = .days
        }
        updateTimeLabel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dateWith(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> NSDate {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        return calendar!.dateFromComponents(components)!
    }
    
    
}

