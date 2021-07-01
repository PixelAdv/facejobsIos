//
//  addressCell.swift
//  Face Jobs
//
//  Created by Apple on 6/10/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit

class address_Cell: UICollectionViewCell {

    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var postalCode: UILabel!
    @IBOutlet weak var valiage: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var country: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
