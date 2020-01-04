//
//  ContactPerson.swift
//  Contacts
//
//  Created by Yang Liu on 1/3/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import Foundation
import UIKit

struct ContactPerson : Codable {
    let first_name: String
    let last_name: String
    let avatar_filename: String
    let title: String
    let introduction: String
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

extension ContactPerson {
    // extract the UIImage from bundle using the image name
    var profileImage: UIImage {
        if let image = UIImage(named: avatar_filename) {
            return image
        } else {
            // if there is no image in the bundle with that image name
            // use a solid gray color image as placeholder
            return UIColor.gray.image()
        }
    }
}
