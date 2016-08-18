//
//  TaskTimer.swift
//  Scheduler
//
//  Created by Vanessa Woo on 3.18.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import Foundation

class TaskTimer {
    private var startTime: NSDate?
    
    var elapsedTime: NSTimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    
    
    var isRunning: Bool {
        return startTime != nil
    }
    
    func start() {
        startTime = NSDate()
    }
    
    func stop() {
        startTime = nil
    }
}