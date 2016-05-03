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
