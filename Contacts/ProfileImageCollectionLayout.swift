//
//  ProfileImageCollectionLayout.swift
//  Contacts
//
//  Created by Yang Liu on 1/5/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class ProfileImageCollectionLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        var currentPage = proposedContentOffset.x / (itemSize.width + minimumLineSpacing)
        if velocity.x > 0 {
            currentPage.round(.awayFromZero)
        } else {
            currentPage.round(.towardZero)
        }
        
        let updatedOffset = (itemSize.width + minimumLineSpacing) * currentPage
        return CGPoint(x: updatedOffset, y: proposedContentOffset.y);
    }
}
