//
//  PostedJobsTableViewCell.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 8/30/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit

class PostedJobsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageJob: UIImageView!
    
    @IBOutlet weak var jobtitlelb: UILabel!
    @IBOutlet weak var companyNamelb: UILabel!
    @IBOutlet weak var Datelb: UILabel!

    @IBOutlet weak var Typelb: UILabel!
    @IBOutlet weak var Daylb: UILabel!

    @IBOutlet weak var Descriptionlb: UILabel!

    @IBOutlet weak var TypeJoblb: UILabel!
    @IBOutlet weak var labguagelb: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
