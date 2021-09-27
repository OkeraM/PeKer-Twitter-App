//
//  TweetCell.swift
//  Twitter
//
//  Created by Okera Murray on 9/25/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var TwitterName: UILabel!
    
    
    @IBOutlet weak var TweetSection: UILabel!
    
    
    @IBOutlet weak var ProfilePic: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
