//
//  ViewController.swift
//  goalpost-app
//
//  Created by Manohar Kurapati on 26/11/2017.
//  Copyright © 2017 Manosoft. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var undoView: UIView!
    

    
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        undoView.alpha = 0.0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    
    //MARK: local functions
    func fetchCoreDataObjects(){
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }//EndOf Self.fetch
    }
    
    //MARK: IBActions
    @IBAction func addGoalBtnPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {
            return
        }
        presentDetail(createGoalVC)
    }//EndOf addGoalBtnPressed
    
    
    @IBAction func undoDeleteBtnPressed(_ sender: Any) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.rollback()
        fetchCoreDataObjects()
        tableView.reloadData()
        
        UIView.animate(withDuration: 0.5) {
            self.undoView.alpha = 0.0
        }
    }//EndOf-undoDeleteBtnPressed
    
}


//MARK: Extensions - UITableView
extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {
            return UITableViewCell()
        }
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.undoView.alpha = 0.0
        let _ = saveGoalsDB()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath)
            in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)

            UIView.animate(withDuration: 0.5, animations: {
                self.undoView.alpha = 1.0
            })
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath)
            in
            
            self.undoView.alpha = 0.0
            if self.saveGoalsDB() != nil {
                self.fetchCoreDataObjects()
                tableView.reloadData()
            }
            
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        addAction.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.662745098, blue: 0.2666666667, alpha: 1)
        
        return [deleteAction, addAction]
    }
    
}

extension GoalsVC {
    
    func setProgress(atIndexPath indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let chosenGoal = goals[indexPath.row]
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress += 1
        } else {
            return
        }
        do{
            try managedContext.save()
            print("Successfully set progress!")
        } catch {
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
    }//EndOf-SetProgress
    
    
    func removeGoal(atIndexPath indexPath: IndexPath){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let _ = saveGoalsDB()
        
        managedContext.delete(goals[indexPath.row])
        
    }//EndOf-removeGoal
    
    func saveGoalsDB() -> Bool?  {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return nil}
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                debugPrint("Could not save the previous delete : \(error.localizedDescription)")
            }
            return true
        } else {
            return nil
        }
    }//EndOf-saveGoalsDB
    
    func fetch(completion: (_ complete: Bool)->()){
        guard  let managedContext = appDelegate?.persistentContainer.viewContext else {  return }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
            goals = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    } //EndOf-fetch
}



