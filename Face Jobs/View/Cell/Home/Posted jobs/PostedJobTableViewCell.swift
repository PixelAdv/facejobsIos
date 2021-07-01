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
    @IBOutlet weak var DeleteBtn: UIButton!
    @IBOutlet weak var AvilableBtn: UIButton!
    @IBOutlet weak var PromoteBtn: UIButton!
    @IBOutlet weak var chatBTN: UIButton!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var aviabkleView: CustomUIView!
    @IBOutlet weak var promotoView: CustomUIView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editBTN: UIButton!
    let constant = Constants.shared

    @IBOutlet weak var EditStack: UIStackView!
    @IBOutlet weak var applayBTN: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
        // Initialization code
    }
    private func setUpView()
    {
        AvilableBtn.layer.cornerRadius = 8
        AvilableBtn.layer.masksToBounds = true
        chatBTN.layer.cornerRadius = 8
        chatBTN.layer.masksToBounds = true
        PromoteBtn.layer.cornerRadius = 8
        PromoteBtn.layer.masksToBounds = true
        chatBTN.titleLabel?.textAlignment = .center
        PromoteBtn.titleLabel?.textAlignment = .center
        AvilableBtn.titleLabel?.textAlignment = .center

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
