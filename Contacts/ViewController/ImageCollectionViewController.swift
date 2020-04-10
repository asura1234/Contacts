//
//  ImageCollectionViewController.swift
//  Contacts
//
//  Created by Yang Liu on 4/10/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class ImageCollectionViewController: UIViewController {

    var profiles: [Profile] = []
    var syncScrollingDelegate: SynchronizedScrollingDelegate?
    
    @IBOutlet private weak var shadowView: ShadowView!
    
    @IBOutlet private weak var imageCollectionView: UICollectionView!
    
    private var imageCollectionLayout =  ProfileImageCollectionLayout()
    
    private let imageCellSize: CGFloat = 80
    private let imageCellSpacing: CGFloat = 10
    private lazy var padding = (imageCollectionView.frame.size.width - imageCellSize)/2
    var contentOffSetRatio: CGFloat {
        get {
            let ratio =  imageCollectionView.contentOffset.x / (imageCollectionView.contentSize.width - 2*padding + imageCollectionLayout.minimumLineSpacing)
            return ratio
        }
        set (ratio) {
            let x = ratio * (imageCollectionView.contentSize.width - 2*padding + imageCollectionLayout.minimumLineSpacing)
            imageCollectionView.contentOffset = CGPoint(x: CGFloat(x), y: 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup profile image collection view
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.isPagingEnabled = false
        imageCollectionView.collectionViewLayout = imageCollectionLayout
        imageCollectionView.accessibilityIdentifier = "profile image collection view"
        
        // set initial selection to item 0
        imageCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
    }
}

extension ImageCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let profile = profiles[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileImageCell", for: indexPath)
        if let profileImageCell = cell as? ProfileImageCell {
            profileImageCell.profile = profile
            profileImageCell.accessibilityIdentifier = "profile image cell at \(indexPath.item)"

        }
        return cell
    }
}

extension ImageCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [.centeredHorizontally])
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // show the shadow under the image collection view
        shadowView.fadeIn()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // hide the shadow under the image collection view
        shadowView.fadeOut()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        syncScrollingDelegate?.didScroll(sender: self, contentOffsetRatio: self.contentOffSetRatio)
        
        // update the selection in the profile image collection view based on
        // which item is currently in the center of the image collection view
        let point = CGPoint(x: imageCollectionView.contentOffset.x, y: imageCollectionView.contentOffset.y + imageCollectionView.frame.height/2)
        if let indexPath = imageCollectionView.indexPathForItem(at: point) {
            imageCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        }
    }
}
