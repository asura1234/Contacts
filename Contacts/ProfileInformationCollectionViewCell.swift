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
                let attributedName = NSMutableAttributedString(string: profile.firstName + " " + profile.lastName);
                
                // make sure the custom font scale to the desired size based on acessibility settings
                let title3Metrics = UIFontMetrics(forTextStyle: .title3)
                let boldFont = title3Metrics.scaledFont(for: UIFont.boldSystemFont(ofSize: 24))
                
                attributedName.addAttribute(.font, value: boldFont, range: NSRange(location: 0, length: profile.firstName.count))
                
                 // make sure the custom font scale to the desired size based on acessibility settings
                let thinFont = title3Metrics.scaledFont(for: UIFont(name: "HelveticaNeue-Light", size: 24) ?? UIFont.systemFont(ofSize: 24))
                attributedName.addAttribute(.font, value: thinFont, range: NSRange(location: profile.firstName.count + 1, length: profile.lastName.count))
                
                nameLabel.attributedText = attributedName
                titleLabel.text = profile.title
                introductionLabel.text = profile.information
            }
        }
    }
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var aboutMeLabel: UILabel!
    @IBOutlet private weak var introductionLabel: UILabel!
}
