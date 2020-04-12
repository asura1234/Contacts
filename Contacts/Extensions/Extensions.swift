//
//  Extensions.swift
//  Contacts
//
//  Created by Yang Liu on 4/10/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public func add(asChildViewController viewController: UIViewController,to parentView:UIView) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        parentView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = parentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    public func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
}

extension UIView {
    private func setupShadow() {
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0
        self.layer.masksToBounds = false
    }
    
    func fadeInShadow() {
        setupShadow()
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.5,
            delay: 0,
            options: [.beginFromCurrentState, .curveEaseInOut],
            animations: {
                self.layer.shadowOpacity = 0.2
            }
        )
    }
    
    func fadeOutShadow() {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.5,
            delay: 0,
            options: [.beginFromCurrentState, .curveEaseInOut],
            animations: {
                self.layer.shadowOpacity = 0
            }
        )
    }
    
    func clipToCircle() {
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height/2
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
