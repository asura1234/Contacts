//
//  ProfileImageCell.swift
//  Contacts
//
//  Created by Yang Liu on 1/3/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class ProfileImageCell: UICollectionViewCell {
    @IBOutlet private weak var profileImage: UIImageView! { didSet {
        profileImage.clipsToBounds = true
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.size.height/2
        }
    }
    
    var profile: Profile? {
        didSet {
            if let profile = profile, let image = UIImage(named: profile.imageName) {
                    profileImage.image = image
            } else {
                // if there is no image in the bundle with that image name
                // use a solid gray color image as placeholder
                profileImage.image =  UIColor.gray.image()
            }
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 5.0
    
    @IBInspectable
    var borderColor: UIColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    
    @IBInspectable
    var borderAlpha: CGFloat = 0.5
    
    override func prepareForReuse() {
        profileImage.image = nil
    }
    
    override func awakeFromNib() {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.frame = profileImage.frame.insetBy(dx: -borderWidth, dy: -borderWidth)
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.borderWidth = 0
        self.layer.borderColor = borderColor.withAlphaComponent(borderAlpha).cgColor
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderWidth = borderWidth
            } else {
                self.layer.borderWidth = 0
            }
        }
    }
}

extension UIColor {
    // generate a UIImage with solid color
    func image(_ size: CGSize = CGSize(width: 85, height: 85)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { renderContext in
            self.setFill()
            renderContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
