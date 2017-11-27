//
//  GoalCell.swift
//  goalpost-app
//
//  Created by Manohar Kurapati on 27/11/2017.
//  Copyright © 2017 Manosoft. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(description: String, type: String, goalProgressAmount: Int) {
        self.goalTypeLbl.text = type
        self.goalDescriptionLbl.text = description
        self.goalProgressLbl.text = String(describing: goalProgressAmount)
    }


}
