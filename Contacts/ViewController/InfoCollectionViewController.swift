//
//  InfoCollectionViewController.swift
//  Contacts
//
//  Created by Yang Liu on 4/10/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class InfoCollectionViewController: UIViewController {

    var profiles: [Profile] = [] {
        didSet {
            infoCollectionView.reloadData()
            contentOffSetRatio = 0
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    var syncScrollingDelegate: SynchronizedScrollingDelegate?
    
    @IBOutlet weak var infoCollectionView: UICollectionView!
    
    private var infoCollectionLayout = UICollectionViewFlowLayout()
    
    var contentOffSetRatio: CGFloat {
        get {
            let ratio = (infoCollectionView.contentOffset.y) / (infoCollectionView.contentSize.height)
            return ratio
        }
        set(ratio) {
            let y = (infoCollectionView.contentSize.height) * ratio
            infoCollectionView.contentOffset = CGPoint(x: 0, y: y)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup profile information collection view
        infoCollectionView.delegate = self
        infoCollectionView.dataSource = self
        infoCollectionView.allowsSelection = false
        infoCollectionView.isPagingEnabled = true
        infoCollectionView.collectionViewLayout = infoCollectionLayout
        infoCollectionView.accessibilityIdentifier = "profile information collection view"
        
        // for paging to work correctly:
        // (1) each item should take up the entire screen space avaialble
        // (2) there can be no horizontal or verticl spacing between each item
        // (3) there can be no inset
        infoCollectionLayout.scrollDirection = .vertical
        infoCollectionLayout.itemSize = infoCollectionView.frame.size
        infoCollectionLayout.minimumLineSpacing = 0
        infoCollectionLayout.minimumInteritemSpacing = 0
        infoCollectionLayout.sectionInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }
}

extension InfoCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let profile = profiles[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileInformationCell", for: indexPath)
        
        if let profileInformationCell = cell as?
            ProfileInfoCell {
            
            profileInformationCell.profile = profile
            profileInformationCell.accessibilityIdentifier = "profile information cell at \(indexPath.row)"
        }
        return cell
    }
}

extension InfoCollectionViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        syncScrollingDelegate?.didScroll(sender: self, contentOffsetRatio: self.contentOffSetRatio)
        
        // update the selection in the profile image collection view based on
        // which item is currently in the center of the profile
        let point = CGPoint(x: infoCollectionView.contentOffset.x, y: infoCollectionView.contentOffset.y + infoCollectionView.frame.height/2)
        if let indexPath = infoCollectionView.indexPathForItem(at: point) {
            infoCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            let selectedIndex = indexPath.item
            syncScrollingDelegate?.didSelect(sender: self, selectedIndex: selectedIndex)
        }
    }
}
