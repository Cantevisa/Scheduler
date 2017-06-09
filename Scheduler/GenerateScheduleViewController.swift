//
//  GenerateScheduleViewController.swift
//  Scheduler
//
//  Created by Vanessa Woo on 3.14.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import UIKit

class GenerateScheduleViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var goButton: UIBarButtonItem!
    @IBOutlet weak var timeSelector: UIDatePicker!
    @IBOutlet weak var warningLabel: UILabel!
    var totalTaskTime: Int = 0
    var taskless: Bool = false
    @IBOutlet weak var warningLabel2: UILabel!
    var warningTimer: Timer?
    let tasks = loadTasks()
    
    struct info {
        static var timeConstraint: Int = 0
    }
    
    //MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        if tasks!.isEmpty {
            warningLabel.text = "Warning: You have no tasks!"
            taskless = true
        }
        for task in tasks! {
            totalTaskTime += task.time
        }
        timeSelector.setDate(Date(), animated: false)
        // There is a bug that makes the value changed event only occur the second time the value is changed. The following line automatically changes the value of the datepicker to 0, 5 so that the user's input is already the second time (apparently 1970 started at 16:00, and 57600 is 16 hours).
        timeSelector.setDate(Date(timeIntervalSince1970: (-57600.0+Double(totalTaskTime))), animated: false)
        warningTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GenerateScheduleViewController.warn), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let timer = self.warningTimer {
            timer.invalidate()
        }
    }
    
    func warn() {
        print("\(timeSelector.countDownDuration) | \(totalTaskTime)")
        if Int(timeSelector.countDownDuration) < totalTaskTime {
            warningLabel.text = "Warning: Not enough time!"
            warningLabel2.text = "You need \(secondsToHoursAndMinutes(totalTaskTime-Int(timeSelector.countDownDuration))) more."
            if Int(timeSelector.countDownDuration) < tasks![0].time {
                goButton.isEnabled = false
            } else {
                goButton.isEnabled = true
            }
        } else {
            warningLabel.text = ""
            warningLabel2.text = ""
            goButton.isEnabled = true
            if taskless {
                warningLabel.text = "Warning: You have no tasks!"
                goButton.isEnabled = false
            }
        }
    }
    
    // MARK: Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        info.timeConstraint = Int(timeSelector.countDownDuration)
        print("Preparing for segue with time constraint of \(info.timeConstraint)")
    }
}
