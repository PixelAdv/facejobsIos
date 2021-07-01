//
//  EmployeeJobCell.swift
//  Face Jobs
//
//  Created by Apple on 3/10/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit

class EmployeeJobCell: UITableViewCell {
    @IBOutlet weak var jobImage: UIImageView!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobloction: UILabel!
    @IBOutlet weak var jobDate: UILabel!
    @IBOutlet weak var jobPrice: UILabel!
    @IBOutlet weak var jobDescription: UILabel!
    @IBOutlet weak var editBTN: UIButton!
    @IBOutlet weak var cancelBTN: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    private func setUpView()
    {
        
        jobImage.layer.cornerRadius = jobImage
            .bounds.height / 2
        jobImage.layer.masksToBounds = true
        editBTN.titleLabel?.textAlignment = .center
        cancelBTN.titleLabel?.textAlignment = .center
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
