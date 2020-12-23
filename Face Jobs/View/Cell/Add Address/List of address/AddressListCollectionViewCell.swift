//
//  AddressListCollectionViewCell.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 8/23/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit

class AddressListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var countrylb: UILabel!
    @IBOutlet weak var citylb: UILabel!
    @IBOutlet weak var villagelb: UILabel!
    @IBOutlet weak var postalcodelb: UILabel!
    @IBOutlet weak var streetNumlb: UILabel!

    @IBOutlet weak var moredetailslb: UILabel!
    
    @IBOutlet weak var locationlb: UILabel!
    @IBOutlet weak var RemoveBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
