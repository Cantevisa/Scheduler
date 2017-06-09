//
//  TaskTableViewController.swift
//  Scheduler
//
//  Created by Vanessa Woo on 3.1.16.
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
    @IBOutlet weak var generateButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        // load if saved
        if let savedTasks = loadTasks() {
            tasks += savedTasks
        }
        
        if StartViewController.States.manual {
            generateButton.title = "Start"
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TaskTableViewCell"
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TaskTableViewCell
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveObject(tasks as NSObject, path: Task.ArchiveURL.path)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        let taskToMove: Task = tasks[fromIndexPath.row]
        tasks.remove(at: fromIndexPath.row)
        tasks.insert(taskToMove, at: toIndexPath.row)
        saveObject(tasks as NSObject, path: Task.ArchiveURL.path)
    }
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return false
     }
     */
    
    // MARK: Navigation
    @IBAction func homePressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        saveObject(tasks as NSObject, path: Task.ArchiveURL.path)
        if segue.identifier == "ShowDetail" {
            print("Editing existing task.")
            let taskDetailViewController = segue.destination as! NewTaskViewController
            
            // Get the cell that generated this segue.
            if let selectedTaskCell = sender as? TaskTableViewCell {
                let indexPath = tableView.indexPath(for: selectedTaskCell)!
                let selectedTask = tasks[indexPath.row]
                taskDetailViewController.task = selectedTask
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new task.")
        }
    }
    
    @IBAction func proceed(_ sender: UIBarButtonItem) {
        if StartViewController.States.manual {
            self.performSegue(withIdentifier: "manualProceed", sender: sender)
        } else {
            self.performSegue(withIdentifier: "autoProceed", sender: sender)
        }
    }
    
    @IBAction func unwindToTaskList(_ sender: UIStoryboardSegue) {
        // if getting this command from the new task view controller
        if let sourceViewController = sender.source as? NewTaskViewController, let task = sourceViewController.task {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // edit existing task
                tasks[selectedIndexPath.row] = task
                // replace row in table
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // add a new task
                let newIndexPath = IndexPath(row: tasks.count, section: 0)
                tasks.append(task)
                // adds new row in table
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
        }
        // save the tasks
        saveObject(tasks as NSObject, path: Task.ArchiveURL.path)
    }
}
