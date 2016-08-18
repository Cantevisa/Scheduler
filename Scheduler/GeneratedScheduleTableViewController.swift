//
//  GeneratedScheduleTableViewController.swift
//  Scheduler
//
//  Created by Vanessa Woo on 3.15.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import UIKit

class GeneratedScheduleTableViewController: UITableViewController {
    
    //MARK: Properties
    var tasks = loadTasks()
    let breakTime = SettingsViewController.CurrentSettings.currentSettings.breakTime * 60
    let longestFirst = SettingsViewController.CurrentSettings.currentSettings.longestFirst
    let highPImage = UIImage(named: "PressedHighPriority")!
    let medPImage = UIImage(named: "PressedMedPriority")!
    let lowPImage = UIImage(named: "PressedLowPriority")!
    let breakImage = UIImage(named: "BreakIcon")!
    
    //MARK: Generation
    func sortTasks(t1: Task, _ t2: Task) -> Bool {
        if t1.priority > t2.priority {
            return true
        } else if t1.priority == t2.priority {
            if longestFirst {
                return t1.time > t2.time
            }
            return t1.time < t2.time
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Adding breaks")
        addBreaks()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "GeneratedTableViewCell"
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TaskTableViewCell
        let task = tasks![indexPath.row]
        
        cell.taskNameLabel.text = task.name
        cell.timeLabel.text = secondsToHoursAndMinutes(task.time)
        if task.priority == 1 {
            cell.priorityImage.image = lowPImage
        } else if task.priority == 2 {
            cell.priorityImage.image = medPImage
        } else if task.priority == 3 {
            cell.priorityImage.image = highPImage
        } else {
            cell.priorityImage.image = breakImage
        }
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let taskToMove: Task = tasks![fromIndexPath.row]
        tasks!.removeAtIndex(fromIndexPath.row)
        tasks!.insert(taskToMove, atIndex: toIndexPath.row)
    }
    
    override func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier != "back" {
            var totalTaskTime: Double = 0.0
            for task in tasks! {
                print("\(task.name)")
                totalTaskTime += Double(task.time)
            }
        }
        saveObject(tasks!, path: Task.ArchiveURL.path!)
    }
    
    //MARK: - Generation
    func addBreaks() {
        let timeConstraint = GenerateScheduleViewController.info.timeConstraint
        tasks = tasks!.sort(sortTasks)
        var totalTaskTime: Int = 0
        for task in tasks! {
            totalTaskTime += task.time
        }
        while timeConstraint - totalTaskTime < 0 {
            let removedTask = tasks!.removeLast()
            totalTaskTime -= removedTask.time
        }
        if timeConstraint - totalTaskTime > breakTime {
            var numBreaks = (timeConstraint - totalTaskTime)/breakTime
            if numBreaks >= tasks!.count {
                numBreaks = tasks!.count - 1
            }
            for var i = 1; i <= numBreaks; i += 1 {
                var insertIndex: Int = (i * numBreaks - 1)
                if insertIndex == 0 {
                    insertIndex += numBreaks
                }
                if insertIndex < tasks!.count {
                    let newBreak = Task(name: "Break", time: breakTime, priority: 0)
                    tasks!.insert(newBreak!, atIndex: insertIndex)
                } else {
                    break
                }
            }
        }
    }
}
