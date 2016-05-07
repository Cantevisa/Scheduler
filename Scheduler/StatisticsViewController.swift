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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedStats = loadStats() {
            var moreOrLess = "more"
            if savedStats.averageDifference < 0 {
                moreOrLess = "less"
            }
            avgDiffLabel.text = "Your estimations are, on average, \(secondsToHoursAndMinutes(savedStats.averageDifference)) \(moreOrLess) than your actual task completion time."
        } else {
            avgDiffLabel.text = "You have not used the app enough to have statistics."
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearStats(sender: UIBarButtonItem) {
        let emptyList = [Statistics]()
        NSKeyedArchiver.archiveRootObject(emptyList, toFile: Statistics.ArchiveURL.path!)
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
