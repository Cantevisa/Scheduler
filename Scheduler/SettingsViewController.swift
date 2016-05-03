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
    
    //MARK: Global Properties
    struct CurrentSettings {
        static var currentSettings: Settings = Settings(breakTime: 10, longestFirst: false)!
    }
    
    //MARK: - Default Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedSettings = loadSettings() {
            CurrentSettings.currentSettings = savedSettings
            breakTimeSlider.setValue(Float(savedSettings.breakTime), animated: false)
            longerTasksSwitch.setOn(savedSettings.longestFirst, animated: false)
        }
        timeLabel.text = String(Int(breakTimeSlider.value))
        NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: "updateSettings", userInfo: nil, repeats: true)

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
        timeLabel.text = String(Int(breakTimeSlider.value))
        if breakTimeSlider.value == 1.0 {
            minutesLabel.text = "minute"
        } else {
            minutesLabel.text = "minutes"
        }
    }
    
    func saveSettings() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(CurrentSettings.currentSettings, toFile: Settings.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save settings.")
        }
    }
    
    func loadSettings() -> Settings? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Settings.ArchiveURL.path!) as? Settings
    }

    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "save" {
            saveSettings()
        }
    }
}
