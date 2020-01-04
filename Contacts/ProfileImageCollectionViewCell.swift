//
//  ProfileImageCollectionViewCell.swift
//  Contacts
//
//  Created by Yang Liu on 1/3/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class ProfileImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImage: CircularImageView!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                profileImage.showBorder = true
            } else {
                profileImage.showBorder = false
            }
        }
    }
}
