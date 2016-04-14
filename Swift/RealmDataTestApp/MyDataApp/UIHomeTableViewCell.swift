//
//  UIHomeTableViewCell.swift
//  MyDataApp
//
//  Created by Seong Hoon Jeong on 2016. 1. 10..
//  Copyright © 2016년 Seong Hoon Jeong. All rights reserved.
//

import UIKit

class UIHomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
