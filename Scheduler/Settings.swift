//
//  Settings.swift
//  Scheduler
//
//  Created by Samantha Cantevisa on 3.23.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import Foundation

class Settings: NSObject, NSCoding {
    
    //MARK: Properties
    var breakTime: Int
    var longestFirst: Bool = false
    var defaultPriority: Int
    //Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("settings")
    
    //MARK: Initialization
    init?(breakTime: Int, longestFirst: Bool, defaultPriority: Int) {
        self.breakTime = breakTime
        self.longestFirst = longestFirst
        self.defaultPriority = defaultPriority
        super.init()
    }
    
    //MARK: - Types
    struct PropertyKeys {
        static let breakTimeKey = "time"
        static let longestKey = "longest"
        static let defaultPriorityKey = "default priority"
    }
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(breakTime, forKey: PropertyKeys.breakTimeKey)
        aCoder.encodeBool(longestFirst, forKey: PropertyKeys.longestKey)
        aCoder.encodeInteger(defaultPriority, forKey: PropertyKeys.defaultPriorityKey)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        let breakTime = aDecoder.decodeIntegerForKey(PropertyKeys.breakTimeKey)
        let longestFirst = aDecoder.decodeBoolForKey(PropertyKeys.longestKey)
        let defaultPriority = aDecoder.decodeIntegerForKey(PropertyKeys.defaultPriorityKey)
        self.init(breakTime: breakTime, longestFirst: longestFirst, defaultPriority: defaultPriority)
}
}