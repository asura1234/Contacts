//
//  CircularImageView.swift
//  Contacts
//
//  Created by Yang Liu on 1/3/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView {

    @IBInspectable
    var borderWidth: CGFloat = 3.0
    
    @IBInspectable
    var borderColor: UIColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    
    @IBInspectable
    var borderAlpha: CGFloat = 0.5
    
    var showBorder: Bool = false {
        didSet {
            if showBorder {
                self.layer.borderWidth = borderWidth
            } else {
                self.layer.borderWidth = 0
            }
        }
    }
    
    private let subLayer = CALayer()
    override func awakeFromNib() {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.borderWidth = 0
        self.layer.borderColor = borderColor.withAlphaComponent(borderAlpha).cgColor
    }
}
