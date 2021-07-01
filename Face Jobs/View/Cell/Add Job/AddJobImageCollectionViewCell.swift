//
//  AddJobImageCollectionViewCell.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/6/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit

class AddJobImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageProJob: UIImageView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
        // Initialization code
    }
    private func setUpView()
    {
        imageProJob.layer.cornerRadius = 5
        imageProJob.layer.masksToBounds = true
    }

}
