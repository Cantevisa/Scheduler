//
//  ViewController.swift
//  Scheduler
//
//  Created by Vanessa Woo on 2.3.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    struct States {
        static var manual = false
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func activateManualMode(_ sender: UIButton) {
        States.manual = true
    }
    @IBAction func activateAutoMode(_ sender: UIButton) {
        States.manual = false
    }
}
