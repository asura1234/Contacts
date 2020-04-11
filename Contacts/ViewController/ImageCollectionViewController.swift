//
//  ImageCollectionViewController.swift
//  Contacts
//
//  Created by Yang Liu on 4/10/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class ImageCollectionViewController: UIViewController {

    var profiles: [Profile] = [] {
        didSet {
            imageCollectionView.reloadData()
            selectedIndex = 0
            contentOffSetRatio = 0
        }
    }
    
    var syncScrollingDelegate: SynchronizedScrollingDelegate?
    
    @IBOutlet private weak var imageCollectionView: UICollectionView!
    
    private var imageCollectionLayout =  ProfileImageCollectionLayout()
    
    private let profileImageCellSize: CGFloat = 80
    private let profileImageCellSpacing: CGFloat = 10
    private lazy var padding = (imageCollectionView.frame.size.width - profileImageCellSize)/2
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
    
    var selectedIndex: Int {
        get {
            let selectedPaths = imageCollectionView.indexPathsForSelectedItems!
            return selectedPaths[0].item
        }
        set (index) {
            imageCollectionView.selectItem(at: IndexPath(item: index, section: 0), animated: false, scrollPosition: [])
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
        
        // for the first item and last item in the profile image collection view
        // to be able to scroll to the center of the collection view,
        // there needs to be padding added on either side of the content
        imageCollectionLayout.scrollDirection = .horizontal
        imageCollectionLayout.itemSize = CGSize(width: profileImageCellSize, height: profileImageCellSize)
        imageCollectionLayout.minimumLineSpacing = profileImageCellSpacing
        imageCollectionLayout.sectionInset = UIEdgeInsets(top: 0,left: padding ,bottom: 0,right: padding)
        
        // set initial selection to item 0
        selectedIndex = 0
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
        self.view.fadeInShadow()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // hide the shadow under the image collection view
        self.view.fadeOutShadow()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        syncScrollingDelegate?.didScroll(sender: self, contentOffsetRatio: self.contentOffSetRatio)
    }
}
