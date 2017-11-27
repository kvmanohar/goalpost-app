//
//  ViewController.swift
//  goalpost-app
//
//  Created by Manohar Kurapati on 26/11/2017.
//  Copyright © 2017 Manosoft. All rights reserved.
//

import UIKit
import CoreData

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func addGoalBtnPressed(_ sender: Any) {
        print("button pressed!!!")
    }



}

