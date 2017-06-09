//
//  StatisticsViewController.swift
//  Scheduler
//
//  Created by Vanessa Woo on 5.6.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var avgDiffLabel: UILabel!
    @IBOutlet weak var coloredLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedStats = loadStats() {
            descriptionLabel.text = "Average difference between estimated time and actual time to complete task:"
            if savedStats.averageDifference < 0 {
                avgDiffLabel.textColor = UIColor.red
                avgDiffLabel.text = "-\(timeAsString(abs(savedStats.averageDifference)))"
            } else {
                avgDiffLabel.textColor = coloredLabel.textColor
                avgDiffLabel.text = "\(timeAsString(savedStats.averageDifference))"
            }
        } else {
            descriptionLabel.text = ""
            avgDiffLabel.text = "You have not used the app enough to have statistics."
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearStats(_ sender: UIBarButtonItem) {
        let emptyList = [Statistics]()
        saveObject(emptyList as NSObject, path: Statistics.ArchiveURL.path)
        descriptionLabel.text = ""
        avgDiffLabel.text = "You have not used the app enough to have statistics."
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
