//
//  ApplicationCVTableViewCell.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 8/26/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit

class ApplicationCVTableViewCell: UITableViewCell {

    @IBOutlet weak var PersonImage: UIImageView!
    
    @IBOutlet weak var personNamelb: UILabel!
    @IBOutlet weak var personRating: FloatRatingView!
    @IBOutlet weak var previousWorklb: UILabel!
    @IBOutlet weak var willCostlb: UILabel!

    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var noteBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
