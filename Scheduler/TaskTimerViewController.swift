//
//  TaskTimerViewController.swift
//  Scheduler
//
//  Created by Samantha Cantevisa on 4.15.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import UIKit

class TaskTimerViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    var tasks = loadTasks()
    private var taskIndex: Int = 0
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
        NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: #selector(TaskTimerViewController.updateElapsedTime(_:)), userInfo: nil, repeats: true)
        taskTimer.start()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Actions
    private func timeAsString (time: Int) -> String {
        let hours = Int(time/3600)
        let minutes = Int((time-hours*3600)/60)
        let seconds = Int(time%60)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func updateElapsedTime(timer: NSTimer) {
        if taskTimer.isRunning {
            timerLabel.text = "\(timeAsString(abs(tasks![taskIndex].time - Int(taskTimer.elapsedTime))))"
            if abs(tasks![taskIndex].time - Int(taskTimer.elapsedTime)) == 0 {
                overtime = -1
            }
        } else {
            timer.invalidate()
        }
    }
    
    @IBAction func nextTask(sender: UIButton) {
        differences.append(overtime*(tasks![taskIndex].time - Int(taskTimer.elapsedTime)))
        taskIndex += 1
        overtime = 1
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
            saveStats()
            print ("Saving stats with averageDifference of \(loadStats()!.averageDifference)")
            self.navigationController!.performSegueWithIdentifier("done", sender: sender)
        }
    }
    
    //MARK: Statistics
    func saveStats() {
        let newStats = Statistics(differences: differences)
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(newStats!, toFile: Statistics.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save tasks.")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    */

}
