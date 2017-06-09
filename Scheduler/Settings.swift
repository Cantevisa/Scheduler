//
//  Settings.swift
//  Scheduler
//
//  Created by Vanessa Woo on 3.23.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import Foundation

class Settings: NSObject, NSCoding {
    
    //MARK: Properties
    var breakTime: Int
    var longestFirst: Bool = false
    var defaultPriority: Int
    //Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("settings")
    
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
    func encode(with aCoder: NSCoder) {
        aCoder.encode(breakTime, forKey: PropertyKeys.breakTimeKey)
        aCoder.encode(longestFirst, forKey: PropertyKeys.longestKey)
        aCoder.encode(defaultPriority, forKey: PropertyKeys.defaultPriorityKey)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        let breakTime = aDecoder.decodeInteger(forKey: PropertyKeys.breakTimeKey)
        let longestFirst = aDecoder.decodeBool(forKey: PropertyKeys.longestKey)
        let defaultPriority = aDecoder.decodeInteger(forKey: PropertyKeys.defaultPriorityKey)
        self.init(breakTime: breakTime, longestFirst: longestFirst, defaultPriority: defaultPriority)
}
}
