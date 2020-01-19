//
//  ContactPerson.swift
//  Contacts
//
//  Created by Yang Liu on 1/3/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import Foundation
import UIKit

struct Profile : Codable {
    let firstName: String
    let lastName: String
    let imageName: String
    let title: String
    let information: String
    
    private enum CodingKeys : String, CodingKey {
        case firstName = "first_ name"
        case lastName = "last_name"
        case imageName = "avatar_filename"
        case title
        case information = "introduction"
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

extension Profile {
    // extract the UIImage from bundle using the image name
    var profileImage: UIImage {
        if let image = UIImage(named: imageName) {
            return image
        } else {
            // if there is no image in the bundle with that image name
            // use a solid gray color image as placeholder
            return UIColor.gray.image()
        }
    }
}
