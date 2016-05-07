//
//  HelperFunctions.swift
//  Scheduler
//
//  Created by Samantha Cantevisa on 5.2.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import Foundation
    
func secondsToHoursAndMinutes (seconds : Int) -> (String) {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    if hours > 0 {
        if hours == 1 {
            return "\(hours) hour and \(minutes) minutes"
        }
        return "\(hours) hours and \(minutes) minutes"
    } else {
        return "\(minutes) minutes"
    }
}

func average (array : [Int]) -> Int {
    var total = 0
    for value in array {
        total += value
    }
    return total/array.count
}

//MARK: NSCoding
func loadTasks() -> [Task]? {
    return NSKeyedUnarchiver.unarchiveObjectWithFile(Task.ArchiveURL.path!) as? [Task]
}

func loadStats() -> Statistics? {
    return NSKeyedUnarchiver.unarchiveObjectWithFile(Statistics.ArchiveURL.path!) as? Statistics
}