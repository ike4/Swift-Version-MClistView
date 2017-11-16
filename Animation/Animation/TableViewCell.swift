//
//  TableViewCell.swift
//  Animation
//
//  Created by ike on 2017/11/5.
//  Copyright © 2017年 ike. All rights reserved.
//

import UIKit

class TableViewCell: MCTableViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
