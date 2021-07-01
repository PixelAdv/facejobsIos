//
//  acceptedPeopleCell.swift
//  Face Jobs
//
//  Created by Apple on 3/2/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit

class acceptedPeopleCell: UITableViewCell {

    
    @IBOutlet weak var personalImage: UIImageView!
   
    
    @IBOutlet weak var jobTitle: UILabel!
    
    
    @IBOutlet weak var previousWorkDES: UILabel!
    @IBOutlet weak var previousWork: UILabel!
    
    @IBOutlet weak var cost: UILabel!
    
    @IBOutlet weak var costDEs: UILabel!
    
    @IBOutlet weak var donotStartYet: UILabel!
    
    @IBOutlet weak var pay: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
