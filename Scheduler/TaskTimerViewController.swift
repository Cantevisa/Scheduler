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
    var tasks = NSKeyedUnarchiver.unarchiveObjectWithFile(Task.ArchiveURL.path!) as? [Task]
    private var taskIndex: Int = 0
    let taskTimer: TaskTimer = TaskTimer()
    let highPImage = UIImage(named: "PressedHighPriority")!
    let medPImage = UIImage(named: "PressedMedPriority")!
    let lowPImage = UIImage(named: "PressedLowPriority")!
    let breakImage = UIImage(named: "BreakIcon")!
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
        NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: "updateElapsedTime:", userInfo: nil, repeats: true)
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
        } else {
            timer.invalidate()
        }
    }
    
    @IBAction func nextTask(sender: UIButton) {
        taskIndex += 1
        print("\(taskIndex) | \(tasks!.count)")
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
            self.navigationController!.performSegueWithIdentifier("done", sender: sender)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
