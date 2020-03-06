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
        case firstName = "first_name"
        case lastName = "last_name"
        case imageName = "avatar_filename"
        case title
        case information = "introduction"
    }
}
