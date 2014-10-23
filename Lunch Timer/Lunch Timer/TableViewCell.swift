//
//  TableViewCell.swift
//  Lunch Timer
//
//  Created by makinoy on 10/18/14.
//  Copyright (c) 2014 makinoy. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var shopImageView : UIImageView?
    @IBOutlet var mainLabel : UILabel?


    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
