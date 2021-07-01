//
//  chatSenderTableViewCell.swift
//  ChatViewDemo
//
//  Created by Boo Doo on 6/2/21.
//

import UIKit

class ChatSenderTableViewCell: UITableViewCell {
  
    @IBOutlet weak var messageContentLabel: UILabel!
    @IBOutlet weak var messageTime: UILabel!
    @IBOutlet weak var reciverName: UILabel!
    @IBOutlet weak var recciverImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configurCell(text: String, image: String, time: String,name: String){
        messageContentLabel.text = text
        recciverImage.loadImageFrom(imgUrl: image)
        reciverName.text = name
        messageTime.text = time
    }
}
