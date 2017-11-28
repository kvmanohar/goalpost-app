//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Manohar Kurapati on 27/11/2017.
//  Copyright © 2017 Manosoft. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    //MARK: IB Outlest
    
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectorColor()
    }

    //MARK: IBActions
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func shortTermBtnPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectorColor()
    }
    
    @IBAction func longTermBtnPressed(_ sender: Any) {
        goalType = .longTerm
        shortTermBtn.setDeselectorColor()
        longTermBtn.setSelectedColor()
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
}
