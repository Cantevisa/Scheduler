//
//  TaskTimerViewController.swift
//  Scheduler
//
//  Created by Vanessa Woo on 4.15.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import UIKit

class TaskTimerViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    var tasks = loadTasks()
    fileprivate var taskIndex: Int = 0
    let taskTimer: TaskTimer = TaskTimer()
    let highPImage = UIImage(named: "PressedHighPriority")!
    let medPImage = UIImage(named: "PressedMedPriority")!
    let lowPImage = UIImage(named: "PressedLowPriority")!
    let breakImage = UIImage(named: "BreakIcon")!
    var differences: [Int] = [Int]()
    //if overtime is 1, then the user still has time left, if overtime is -1, then the user has used all of their time already
    var overtime = 1
    @IBOutlet weak var iconView: UIImageView!
    
    //MARK: - Defaults
    override func viewDidLoad() {
        super.viewDidLoad()
        let task = tasks![taskIndex]
        taskLabel.text = task.name
        for task in tasks! {
            print("Timer: \(task.name)")
        }
        if task.priority == 1 {
            iconView.image = lowPImage
        } else if task.priority == 2 {
            iconView.image = medPImage
        } else if task.priority == 3 {
            iconView.image = highPImage
        } else {
            iconView.image = breakImage
        }
        
        if let savedStats = loadStats() {
            differences = savedStats.differences
        }
        Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(TaskTimerViewController.updateElapsedTime(_:)), userInfo: nil, repeats: true)
        taskTimer.start()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Actions
    func updateElapsedTime(_ timer: Timer) {
        if taskTimer.isRunning {
            timerLabel.text = "\(timeAsString(abs(tasks![taskIndex].time - Int(taskTimer.elapsedTime))))"
            if tasks![taskIndex].time - Int(taskTimer.elapsedTime) <= 0 {
                overtime = -1
                timerLabel.textColor = UIColor.red
            }
        } else {
            timer.invalidate()
        }
    }
    
    @IBAction func nextTask(_ sender: UIButton) {
        differences.append(overtime*(tasks![taskIndex].time - Int(taskTimer.elapsedTime)))
        taskIndex += 1
        overtime = 1
        timerLabel.textColor = UIColor.black
        if taskIndex < tasks!.count {
            taskTimer.start()
            let task = tasks![taskIndex]
            taskLabel.text = task.name
            if task.priority == 1 {
                iconView.image = lowPImage
            } else if task.priority == 2 {
                iconView.image = medPImage
            } else if task.priority == 3 {
                iconView.image = highPImage
            } else {
                iconView.image = breakImage
            }
        } else {
            print("done with everything")
            taskTimer.stop()
            let newStats = Statistics(differences: differences)
            saveObject(newStats!, path: Statistics.ArchiveURL.path)
            print ("Saving stats with averageDifference of \(loadStats()!.averageDifference)")
            self.performSegue(withIdentifier: "done", sender: sender)
        }
    }
    
    // MARK: - Navigation

     @IBAction func cancelTimer(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
     }
}
