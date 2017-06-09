//
//  Statistics.swift
//  Scheduler
//
//  Created by Vanessa Woo on 5.6.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import UIKit

class Statistics: NSObject, NSCoding {
    //MARK: Properties
    let differences: [Int]
    let averageDifference: Int
    //Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("statistics")
    
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
    func encode(with aCoder: NSCoder) {
        aCoder.encode(differences, forKey: PropertyKey.diffKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let differences = aDecoder.decodeObject(forKey: PropertyKey.diffKey) as! [Int]
        self.init(differences: differences)
    }
}
