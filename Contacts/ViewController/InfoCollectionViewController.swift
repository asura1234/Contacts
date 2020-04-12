//
//  InfoCollectionViewController.swift
//  Contacts
//
//  Created by Yang Liu on 4/10/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class InfoCollectionViewController: UIViewController {

    public init(with profiles: [Profile]) {
        super.init(nibName: nil, bundle: nil)
        self.profiles = profiles
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var profiles: [Profile] = []
    
    var syncScrollingDelegate: SynchronizedScrollingDelegate?
    
    private lazy var infoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: infoCollectionLayout)
        // setup profile information collection view
        collectionView.backgroundColor = UIColor.systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = false
        collectionView.isPagingEnabled = true
        collectionView.register(ProfileInfoCell.self, forCellWithReuseIdentifier: "ProfileInfoCell")
        collectionView.accessibilityIdentifier = "profile information collection view"
       collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var infoCollectionLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        // for paging to work correctly:
        // (1) each item should take up the entire screen space avaialble
        // (2) there can be no horizontal or verticl spacing between each item
        // (3) there can be no inset
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        return flowLayout
    }()
    
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
    
    private func setupViews() {
        view.addSubview(infoCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            infoCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            infoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            infoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        contentOffSetRatio = 0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        infoCollectionLayout.itemSize = infoCollectionView.frame.size
    }
}

extension InfoCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let profile = profiles[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileInfoCell", for: indexPath)
        
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
