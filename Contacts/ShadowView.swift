//
//  ShadowView.swift
//  Contacts
//
//  Created by Yang Liu on 3/6/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    func fadeIn() {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.5,
            delay: 0,
            options: [.beginFromCurrentState, .curveEaseInOut],
            animations: {
                self.layer.shadowOpacity = 0.2
            }
        )
    }
    
    func fadeOut() {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.5,
            delay: 0,
            options: [.beginFromCurrentState, .curveEaseInOut],
            animations: {
                self.layer.shadowOpacity = 0
            }
        )
    }
    
    override func awakeFromNib() {
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0
        self.layer.masksToBounds = false
    }
}
