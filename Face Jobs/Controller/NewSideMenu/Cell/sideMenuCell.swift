//
//  sideMenuCell.swift
//  Face Jobs
//
//  Created by Apple on 3/22/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit

class sideMenuCell: UITableViewCell {

    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var leadingPhotoConstraint: NSLayoutConstraint!
    @IBOutlet weak var RightImageLeading: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpview()
    }
    private func setUpview()
    {
        self.selectionStyle = .none
    }
    func setCellData(image: UIImage, title: String, showLeftImage: Bool)
    {
        self.rightImage.image = image
        self.titleLBL.text = title
        self.leftImage.isHidden = showLeftImage
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
