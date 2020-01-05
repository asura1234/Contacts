//
//  CircularImageView.swift
//  Contacts
//
//  Created by Yang Liu on 1/3/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView {

    // clip the source image in a cirlce
    override func awakeFromNib() {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.size.height/2
    }
}
