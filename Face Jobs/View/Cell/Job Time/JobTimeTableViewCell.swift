//
//  JobTimeTableViewCell.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/7/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit

class JobTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var DateJob: UILabel!
    @IBOutlet weak var Time1Job: UILabel!
    @IBOutlet weak var Time2Job: UILabel!

    @IBOutlet weak var RemoveBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
