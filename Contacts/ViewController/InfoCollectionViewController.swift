//
//  InfoCollectionViewController.swift
//  Contacts
//
//  Created by Yang Liu on 4/10/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class InfoCollectionViewController: UIViewController {

    var profiles: [Profile] = []
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
    }
}
