//
//  NewTaskViewController.swift
//  Scheduler
//
//  Created by Vanessa Woo on 3.4.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var prioritySystem: PrioritySystem!
    @IBOutlet weak var timeSelector: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        // Check if task already exists
        if let task = task {
            navigationItem.title = task.name
            nameTextField.text = task.name
            prioritySystem.priority = task.priority
            prioritySystem.updateButtonSelectionStates()
            timeSelector.countDownDuration = Double(task.time)
        }
        // Do any additional setup after loading the view, typically from a nib.
        checkValidTaskName()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func checkValidTaskName() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidTaskName()
        navigationBar.title = nameTextField.text
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let name = nameTextField.text ?? ""
        let time = Int(timeSelector.countDownDuration)
        let priority = prioritySystem.priority
        task = Task(name: name, time: time, priority: priority)
    }
}
