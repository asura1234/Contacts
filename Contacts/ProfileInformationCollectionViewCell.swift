//
//  ProfileInformationCollectionViewCell.swift
//  Contacts
//
//  Created by Yang Liu on 1/4/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class ProfileInformationCollectionViewCell: UICollectionViewCell {
    var profile: Profile? {
        didSet {
            if let profile = profile {
                nameLabel.attributedText = fullName
                titleLabel.text = profile.title
                introductionLabel.text = profile.information
            }
        }
    }
    
    private var fullName: NSMutableAttributedString {
        if let profile = profile {
            let descriptor = UIFont.preferredFont(forTextStyle: .title3)
            let firstNameAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: descriptor.pointSize)]
            let lastNameAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: descriptor.pointSize)!]
            
            let firstName = NSMutableAttributedString(string: profile.firstName, attributes: firstNameAttributes)
            let space = NSMutableAttributedString(string: " ")
            let lastName = NSMutableAttributedString(string: profile.lastName, attributes: lastNameAttributes)
            
            let fullName = NSMutableAttributedString()
            fullName.append(firstName)
            fullName.append(space)
            fullName.append(lastName)
            
            return fullName
        }
        return NSMutableAttributedString(string: "")
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        titleLabel.text = nil
        introductionLabel.text = nil
    }
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var aboutMeLabel: UILabel!
    @IBOutlet private weak var introductionLabel: UILabel!
}
