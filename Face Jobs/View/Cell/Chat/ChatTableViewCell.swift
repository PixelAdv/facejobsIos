//
//  ChatTableViewCell.swift
//  ChatViewDemo
//
//  Created by Boo Doo on 6/2/21.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var senderImage: UIImageView!
    @IBOutlet weak var messageContentLabel: UILabel!
    @IBOutlet weak var messageTime: UILabel!
    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configurCell(text: String, image: String, time: String,name: String){
        messageContentLabel.text = text
        senderImage.loadImageFrom(imgUrl: image)
        senderName.text = name
        messageTime.text = time
    }
    
}
