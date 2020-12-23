//
//  DocumentTableViewCell.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/30/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit

class DocumentTableViewCell: UITableViewCell {

    @IBOutlet weak var Documlb: UILabel!
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
