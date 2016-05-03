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
    //Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("settings")
    
    //MARK: Initialization
    init?(breakTime: Int, longestFirst: Bool) {
        self.breakTime = breakTime
        self.longestFirst = longestFirst
        super.init()
    }
    
    //MARK: - Types
    struct PropertyKeys {
        static let breakTimeKey = "time"
        static let longestKey = "longest"
    }
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(breakTime, forKey: PropertyKeys.breakTimeKey)
        aCoder.encodeBool(longestFirst, forKey: PropertyKeys.longestKey)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        let breakTime = aDecoder.decodeIntegerForKey(PropertyKeys.breakTimeKey)
        let longestFirst = aDecoder.decodeBoolForKey(PropertyKeys.longestKey)
        self.init(breakTime: breakTime, longestFirst: longestFirst)
}
}