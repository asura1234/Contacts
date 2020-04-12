//
//  ProfileInformationCollectionViewCell.swift
//  Contacts
//
//  Created by Yang Liu on 1/4/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class ProfileInfoCell: UICollectionViewCell {
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = UIColor.lightGray
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    private lazy var aboutMeLabel: UILabel = {
        let label = UILabel()
        label.text = "About me"
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private lazy var introductionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.autoresizingMask = .flexibleHeight
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            titleLabel,
            aboutMeLabel,
            introductionLabel
        ])
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var profile: Profile? {
        didSet {
            if let profile = profile {
                nameLabel.attributedText = fullName
                titleLabel.text = profile.title
                introductionLabel.text = profile.information
            }
        }
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
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
}
