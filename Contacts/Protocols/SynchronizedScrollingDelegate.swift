//
//  SynchronizedScrollingDelegate.swift
//  Contacts
//
//  Created by Yang Liu on 4/10/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import Foundation
import UIKit

protocol SynchronizedScrollingDelegate
{
    func didScroll(sender: UIViewController, contentOffsetRatio: CGFloat)
}

