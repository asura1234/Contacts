//
//  ProfileImageCollectionLayout.swift
//  Contacts
//
//  Created by Yang Liu on 1/5/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class ProfileImageCollectionLayout: UICollectionViewFlowLayout {
    
    var previousVelocity = CGPoint.zero
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = self.collectionView else {
            return CGPoint.zero
        }
        
        if velocity.x == 0 {
            return proposedContentOffset
        }
    
        let itemEdgeOffset:CGFloat = (collectionView.frame.width - itemSize.width -  minimumLineSpacing * 2) / 2

        var currentPage = ((proposedContentOffset.x - itemEdgeOffset) / itemSize.width)
        if velocity.x > 0 {
            currentPage.round(.awayFromZero)
        } else {
            currentPage.round(.towardZero)
        }
        
        let updatedOffset: CGFloat = (itemSize.width + minimumLineSpacing) * currentPage - (itemEdgeOffset + 2*minimumLineSpacing);
        
        return CGPoint(x: updatedOffset, y: proposedContentOffset.y);
    }
}
