//
//  PostedJobTableViewCell.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/28/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit

class PostedJobTableViewCell: UITableViewCell {

    @IBOutlet weak var JobImage: UIImageView!
    @IBOutlet weak var JobTitlelb: UILabel!
    @IBOutlet weak var JobApprovedlb: UILabel!

    @IBOutlet weak var Joblocationlb: UILabel!
    @IBOutlet weak var JobHourlb: UILabel!
    @IBOutlet weak var JobDailylb: UILabel!
    
    @IBOutlet weak var EditBtn: UIButton!
    @IBOutlet weak var DeleteBtn: UIButton!
    @IBOutlet weak var AvilableBtn: UIButton!
    @IBOutlet weak var PromoteBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
