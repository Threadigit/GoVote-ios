//
//  UserTableViewCell.swift
//  govote
//
//  Created by Adetuyi Tolu Emmanuel on 3/2/18.
//  Copyright © 2018 Adetuyi Tolu Emmanuel. All rights reserved.
//

import UIKit

class LocTableViewCell: UITableViewCell {

    @IBOutlet var locationImageView : UIImageView!
    @IBOutlet var locationName : UILabel!
    @IBOutlet var locationArea : UILabel!
    @IBOutlet var favBtn: UIButton!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
