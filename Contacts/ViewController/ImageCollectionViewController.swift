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
    
    private lazy var imageCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: self.imageCollectionLayout)
        // setup profile image collection view
        collectionView.backgroundColor = UIColor.systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = false
        collectionView.register(ProfileImageCell.self, forCellWithReuseIdentifier: "ProfileImageCell")
        collectionView.accessibilityIdentifier = "profile image collection view"
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let profileImageCellSize: CGFloat = 80
    private let profileImageCellSpacing: CGFloat = 10
    private lazy var padding = (self.view.frame.size.width - profileImageCellSize)/2
    
    private lazy var imageCollectionLayout: ProfileImageCollectionLayout =  {
        let collectionLayout = ProfileImageCollectionLayout()
        // for the first item and last item in the profile image collection view
        // to be able to scroll to the center of the collection view,
        // there needs to be padding added on either side of the content
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = CGSize(width: profileImageCellSize, height: profileImageCellSize)
        collectionLayout.minimumLineSpacing = profileImageCellSpacing
        collectionLayout.sectionInset = UIEdgeInsets(top: 0,left: padding ,bottom: 0,right: padding)
        return collectionLayout
    }()
    
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
    
    private func setupViews() {
        view.addSubview(imageCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            imageCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        // set initial selection to item 0
        selectedIndex = 0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
