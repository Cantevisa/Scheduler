//
//  HelperFunctions.swift
//  Scheduler
//
//  Created by Vanessa Woo on 5.2.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import Foundation

//MARK: Time Formatting
func secondsToHoursAndMinutes (_ seconds : Int) -> (String) {
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

func timeAsString (_ time: Int) -> String {
    let hours = Int(time/3600)
    let minutes = Int((time-hours*3600)/60)
    let seconds = Int(time%60)
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
}

//MARK: Math
func average (_ array : [Int]) -> Int {
    var total = 0
    for value in array {
        total += value
    }
    return total/array.count
}

//MARK: - NSCoding
func loadTasks() -> [Task]? {
    return NSKeyedUnarchiver.unarchiveObject(withFile: Task.ArchiveURL.path) as? [Task]
}

func loadStats() -> Statistics? {
    return NSKeyedUnarchiver.unarchiveObject(withFile: Statistics.ArchiveURL.path) as? Statistics
}

func loadSettings() -> Settings? {
    return NSKeyedUnarchiver.unarchiveObject(withFile: Settings.ArchiveURL.path) as? Settings
}

func saveObject(_ object: NSObject, path: String) {
    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(object, toFile: path)
    if !isSuccessfulSave {
        print("Failed to save tasks.")
    }
}
