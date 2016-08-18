//
//  Task.swift
//  Scheduler
//
//  Created by Vanessa Woo on 2.29.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import UIKit

class Task: NSObject, NSCoding {
    //MARK: Properties
    let name: String
    let time: Int
    let priority: Int
    //Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("tasks")
    
    //MARK: - Types
    struct PropertyKey {
        static let nameKey = "name"
        static let timeKey = "time"
        static let priorityKey = "priority"
    }
    
    //MARK: Initialization
    init?(name:String, time:Int, priority:Int) {
        self.name = name
        self.time = time
        self.priority = priority
        super.init()
        
        // If name is empty, initialization should fail
        if name.isEmpty {
            return nil
        }
    }
    
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeInteger(time, forKey: PropertyKey.timeKey)
        aCoder.encodeInteger(priority, forKey: PropertyKey.priorityKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let priority = aDecoder.decodeIntegerForKey(PropertyKey.priorityKey)
        let time = aDecoder.decodeIntegerForKey(PropertyKey.timeKey)
        self.init(name:name, time:time, priority:priority)
    }
}