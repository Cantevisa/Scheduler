//
//  Statistics.swift
//  Scheduler
//
//  Created by Samantha Cantevisa on 5.6.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import UIKit

class Statistics: NSObject, NSCoding {
    //MARK: Properties
    let differences: [Int]
    let averageDifference: Int
    //Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("statistics")
    
    //MARK: - Types
    struct PropertyKey {
        static let diffKey = "differences"
    }
    
    //MARK: Initialization
    init?(differences: [Int]) {
        self.differences = differences
        self.averageDifference = average(differences)
        super.init()
    }
    
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(differences, forKey: PropertyKey.diffKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let differences = aDecoder.decodeObjectForKey(PropertyKey.diffKey) as! [Int]
        self.init(differences: differences)
    }
}