//
//  ProfileImageCell.swift
//  Contacts
//
//  Created by Yang Liu on 1/3/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class ProfileImageCell: UICollectionViewCell {
    private lazy var profileImage: UIImageView = {
        let image = UIImageView(frame: contentView.frame.insetBy(dx: 2*borderWidth, dy: 2*borderWidth))
        image.clipToCircle()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
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
    
    var borderWidth: CGFloat = 5.0

    var borderColor: UIColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    
    var borderAlpha: CGFloat = 0.5
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(profileImage)
        contentView.clipToCircle()
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = borderColor.withAlphaComponent(borderAlpha).cgColor
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0, constant: -2*borderWidth),
            profileImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1.0, constant: -2*borderWidth)
        ])
    }
    
    override func prepareForReuse() {
        profileImage.image = nil
        profile = nil
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.layer.borderWidth = borderWidth
            } else {
                contentView.layer.borderWidth = 0
            }
        }
    }
}
