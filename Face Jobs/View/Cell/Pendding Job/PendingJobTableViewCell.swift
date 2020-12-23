//
//  PendingJobTableViewCell.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/13/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit

class PendingJobTableViewCell: UITableViewCell {

    @IBOutlet weak var resendView: CustomUIView!
    @IBOutlet weak var PendImage: UIImageView!
    @IBOutlet weak var PendTitlelb: UILabel!
    @IBOutlet weak var PendSciencelb: UILabel!

    @IBOutlet weak var Pendlocationlb: UILabel!
    @IBOutlet weak var PendHourlb: UILabel!
    @IBOutlet weak var PendDailylb: UILabel!
    
    @IBOutlet weak var EditBtn: UIButton!
    @IBOutlet weak var DeleteBtn: UIButton!
    @IBOutlet weak var ResendBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
