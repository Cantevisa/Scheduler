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
    
    struct info {
        static var timeConstraint: Int = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // There is a bug that makes the value changed event only occur the second time the value is changed. The following line automatically changes the value of the datepicker to 0, 5 so that the user's input is already the second time (apparently 1970 started at 16:00, and 57600 is 16 hours).
        timeSelector.setDate(NSDate(timeIntervalSince1970: -57600.0), animated: false)
        let tasks = NSKeyedUnarchiver.unarchiveObjectWithFile(Task.ArchiveURL.path!) as? [Task]
        if tasks!.isEmpty {
            warningLabel.text = "Warning: You have no tasks!"
            taskless = true
        }
        for task in tasks! {
            totalTaskTime += task.time
        }
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateWarning(sender: UIDatePicker) {
        print("\(timeSelector.countDownDuration) | \(totalTaskTime)")
        if Int(timeSelector.countDownDuration) < totalTaskTime {
            print("meow")
            warningLabel.text = "Warning: Not enough time!"
        } else {
            warningLabel.text = ""
            if taskless {
                warningLabel.text = "Warning: You have no tasks!"
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if goButton === sender {
            info.timeConstraint = Int(timeSelector.countDownDuration)
            print("Preparing for segue with time constraint of \(info.timeConstraint)")
        }
    }
}
