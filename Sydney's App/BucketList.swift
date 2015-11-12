//
//  BucketList.swift
//  Sydney's App
//
//  Created by Micah Wilson on 10/31/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import UIKit
import Parse

class BucketList {
    var title: String!
    var icon: UIImage!
    var list: [String]?
    var listProgress: [Bool]?
    var id: String!
    var pfObject: PFObject!
    
    init(title: String) {
        self.title = title
    }
}
