//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Manohar Kurapati on 28/11/2017.
//  Copyright © 2017 Manosoft. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    //MARK: IBOutlets
    
    @IBOutlet weak var pointsTextField: UITextField!
    @IBOutlet weak var createGoalBtn: UIButton!
    var goalDescription: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType){
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pointsTextField.delegate = self
        createGoalBtn.bindToKeyboard()
    }

    @IBAction func createGoalBtnPressed(_ sender: Any) {
    }
    

}
