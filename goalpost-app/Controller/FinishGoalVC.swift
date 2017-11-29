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

    //MARK: Local functions
    func saveData(completion:(_ finished: Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managedContext.save()
            completion(true)
            
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)" )
            completion(false)
        }
        
    }
    
    
    //MARK: IBActions

    @IBAction func createGoalBtnPressed(_ sender: Any) {
        if pointsTextField.text != "" {
            self.saveData { (complete) in
                if complete {
                    print("Data Saved successfully")
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }//EndOf CreateGoalBtnPressed
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
}
