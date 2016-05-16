//
//  SettingsViewController.swift
//  Scheduler
//
//  Created by Samantha Cantevisa on 3.16.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var breakTimeSlider: UISlider!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var longerTasksSwitch: UISwitch!
    @IBOutlet weak var defaultPrioritySelector: PrioritySystem!
    
    //MARK: Global Properties
    struct CurrentSettings {
        static var currentSettings: Settings = Settings(breakTime: 10, longestFirst: false, defaultPriority: 1)!
    }
    
    //MARK: - Default Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedSettings = loadSettings() {
            CurrentSettings.currentSettings = savedSettings
            breakTimeSlider.setValue(Float(savedSettings.breakTime), animated: false)
            longerTasksSwitch.setOn(savedSettings.longestFirst, animated: false)
            defaultPrioritySelector.priority = savedSettings.defaultPriority
            defaultPrioritySelector.updateButtonSelectionStates()
        }
        timeLabel.text = String(Int(breakTimeSlider.value))
        NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: #selector(SettingsViewController.updateSettings), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Saving and Loading
    func updateSettings() {
        CurrentSettings.currentSettings.breakTime = Int(breakTimeSlider.value)
        CurrentSettings.currentSettings.longestFirst = longerTasksSwitch.on
        CurrentSettings.currentSettings.defaultPriority = defaultPrioritySelector.priority
        timeLabel.text = String(Int(breakTimeSlider.value))
        if breakTimeSlider.value == 1.0 {
            minutesLabel.text = "minute"
        } else {
            minutesLabel.text = "minutes"
        }
    }

    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "save" {
            saveObject(CurrentSettings.currentSettings, path: Settings.ArchiveURL.path!)
        }
    }
}
