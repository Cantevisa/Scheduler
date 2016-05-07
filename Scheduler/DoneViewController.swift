//
//  DoneViewController.swift
//  Scheduler
//
//  Created by Samantha Cantevisa on 4.19.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import UIKit

class DoneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let emptyList = [Task]()
        NSKeyedArchiver.archiveRootObject(emptyList, toFile: Task.ArchiveURL.path!)
    }

}
