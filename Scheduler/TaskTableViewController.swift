//
//  TaskTableViewController.swift
//  Scheduler
//
//  Created by Samantha Cantevisa on 3.1.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {
    
    //MARK: Properties
    var tasks: [Task] = [Task]()
    let highPImage = UIImage(named: "PressedHighPriority")!
    let medPImage = UIImage(named: "PressedMedPriority")!
    let lowPImage = UIImage(named: "PressedLowPriority")!
    let breakImage = UIImage(named: "BreakIcon")!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        // load if saved
        if let savedTasks = loadTasks() {
            tasks += savedTasks
        }
    }

//    func loadSampleTasks() {
//        let task1 = Task(name: "Eat Food", time: 50, priority: 1)
//        tasks.append(task1!)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View Data Source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "TaskTableViewCell"
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TaskTableViewCell
        let task = tasks[indexPath.row]

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
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tasks.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            saveObject(tasks, path: Task.ArchiveURL.path!)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let taskToMove: Task = tasks[fromIndexPath.row]
        tasks.removeAtIndex(fromIndexPath.row)
        tasks.insert(taskToMove, atIndex: toIndexPath.row)
        saveObject(tasks, path: Task.ArchiveURL.path!)
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return false
    }
    */

    // MARK: Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        saveObject(tasks, path: Task.ArchiveURL.path!)
        if segue.identifier == "ShowDetail" {
            print("Editing existing task.")
            let taskDetailViewController = segue.destinationViewController as! NewTaskViewController
            
            // Get the cell that generated this segue.
            if let selectedTaskCell = sender as? TaskTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedTaskCell)!
                let selectedTask = tasks[indexPath.row]
                taskDetailViewController.task = selectedTask
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new task.")
        }
    }
    
    @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
        // if getting this command from the new task view controller
        if let sourceViewController = sender.sourceViewController as? NewTaskViewController, task = sourceViewController.task {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // edit existing task
                tasks[selectedIndexPath.row] = task
                // replace row in table
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // add a new task
                let newIndexPath = NSIndexPath(forRow: tasks.count, inSection: 0)
                tasks.append(task)
                // adds new row in table
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
        // save the tasks
        saveObject(tasks, path: Task.ArchiveURL.path!)
    }

    //MARK: NSCoding
    
    
}
