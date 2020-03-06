//
//  ViewController.swift
//  Contacts
//
//  Created by Yang Liu on 1/3/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var profileImagecollectionView: UICollectionView!
    @IBOutlet weak var profileInformationCollectionView: UICollectionView!
    
    var profiles: [Profile] = []
    var selectedIndex: Int = 0
    
    private let profileImageCellSize: CGFloat = 80
    private let profileImageCellSpacing: CGFloat = 10
    private lazy var padding = (profileImagecollectionView.frame.size.width - profileImageCellSize)/2
    
    private let profileImageLayout = ProfileImageCollectionLayout()
    private let profileInformationLayout = UICollectionViewFlowLayout()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // for the first item and last item in the profile image collection view
        // to be able to scroll to the center of the collection view,
        // there needs to be padding added on either side of the content
        profileImageLayout.scrollDirection = .horizontal
        profileImageLayout.itemSize = CGSize(width: profileImageCellSize, height: profileImageCellSize)
        profileImageLayout.minimumLineSpacing = profileImageCellSpacing
        profileImageLayout.sectionInset = UIEdgeInsets(top: 0,left: padding ,bottom: 0,right: padding)
        
        // the shadow scrolls with the items inside profile image collection view
        // so I had to make it really wide ...
        profileImagecollectionView.layer.shadowPath = UIBezierPath(rect: CGRect(origin: CGPoint(x: -padding, y: 0), size: CGSize(width: profileImagecollectionView.contentSize.width + 2*padding, height: profileImagecollectionView.frame.height))).cgPath
        
        // for paging to work correctly:
        // (1) each item should take up the entire screen space avaialble
        // (2) there can be no horizontal or verticl spacing between each item
        // (3) there can be no inset
        profileInformationLayout.scrollDirection = .vertical
        profileInformationLayout.itemSize = profileInformationCollectionView.frame.size
        profileInformationLayout.minimumLineSpacing = 0
        profileInformationLayout.minimumInteritemSpacing = 0
        profileInformationLayout.sectionInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the title on the navigation bar
        navigationItem.title = "Contacts"
        
        // deserialize the contacts.json file to an array of ContactPerson Objects
        if let path = Resources.contactsJsonPath, let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            let decoder = JSONDecoder()
            if let profiles = try? decoder.decode([Profile].self, from: data) {
                self.profiles = profiles
            } else {
                print("Not able to decode contacts.json file. ")
            }
        } else {
            print("Not able to locate contacts.json file in the bundle.")
        }
        
        // setup profile image collection view
        profileImagecollectionView.delegate = self
        profileImagecollectionView.dataSource = self
        profileImagecollectionView.isPagingEnabled = false
        profileImagecollectionView.collectionViewLayout = profileImageLayout
        profileImagecollectionView.accessibilityIdentifier = "profile image collection view"
        
        // setup the shadow under the image collection view
        profileImagecollectionView.layer.shadowColor = UIColor.gray.cgColor
        profileImagecollectionView.layer.shadowRadius = 2
        profileImagecollectionView.layer.shadowOffset = CGSize(width: 0, height: 3)
        profileImagecollectionView.layer.shadowOpacity = 0
        profileImagecollectionView.layer.masksToBounds = false
        
        // setup profile information collection view
        profileInformationCollectionView.delegate = self
        profileInformationCollectionView.dataSource = self
        profileInformationCollectionView.allowsSelection = false
        profileInformationCollectionView.isPagingEnabled = true
        profileInformationCollectionView.collectionViewLayout = profileInformationLayout
        profileInformationCollectionView.accessibilityIdentifier = "profile information collection view"
        
        // set initial selection to item 0
        profileImagecollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
    }
}

// MARK: Implement UICollectionViewDataSource
extension ContactsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let profile = profiles[indexPath.item]
        if collectionView == profileImagecollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileImageCell", for: indexPath)
            if let profileImageCell = cell as? ProfileImageCollectionViewCell {
                profileImageCell.profile = profile
                profileImageCell.accessibilityIdentifier = "profile image cell at \(indexPath.row)"
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileInformationCell", for: indexPath)
            
            if let profileInformationCell = cell as?
                ProfileInformationCollectionViewCell {
                
                profileInformationCell.profile = profile
                profileInformationCell.accessibilityIdentifier = "profile information cell at \(indexPath.row)"
            }
            return cell
        }
    }
}

//MARK: Implement UICollectionViewDelegate
extension ContactsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        profileImagecollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [.centeredHorizontally])
        selectedIndex = indexPath.item
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // show the shadow under the image collection view
        UIView.transition(
        with: profileImagecollectionView,
        duration: 0.5,
        options: [.beginFromCurrentState, .curveEaseInOut],
        animations: {
            self.profileImagecollectionView.layer.shadowOpacity = 0.2
        })
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // hide the shadow under the image collection view
        UIView.transition(
        with: profileImagecollectionView,
        duration: 0.5,
        options: [.beginFromCurrentState, .curveEaseInOut],
        animations: {
            self.profileImagecollectionView.layer.shadowOpacity = 0
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // synchronize scrolling between the two collection views
        if scrollView == profileImagecollectionView {
            let percentage = profileImagecollectionView.contentOffset.x / (profileImagecollectionView.contentSize.width - 2*padding + profileImageLayout.minimumLineSpacing)
            let y = (profileInformationCollectionView.contentSize.height) * percentage
            profileInformationCollectionView.contentOffset = CGPoint(x: 0, y: y)
        } else if scrollView == profileInformationCollectionView {
            let percentage = (profileInformationCollectionView.contentOffset.y) / (profileInformationCollectionView.contentSize.height)
            let x = (profileImagecollectionView.contentSize.width - 2*padding + profileImageLayout.minimumLineSpacing) * percentage
            profileImagecollectionView.contentOffset = CGPoint(x: CGFloat(x), y: 0)
        }
        
        // print out the contentOffset and index
        // to verify the two collection views are scrolling in sync
        #if DEBUG
        print("Profile Image View Content Offset")
        print("x: \(profileImagecollectionView.contentOffset.x), index: \((profileImagecollectionView.contentOffset.x / (profileImageLayout.itemSize.width + profileImageLayout.minimumLineSpacing) * 10).rounded() / 10)")
        print("Profile Information View Content Offset")
        print("x: \(profileInformationCollectionView.contentOffset.y), index: \((profileInformationCollectionView.contentOffset.y / profileInformationLayout.itemSize.height * 10).rounded() / 10)")
        #endif
        
        // update the selection in the profile image collection view based on
        // which item is currently in the center of the profile information collection view
        if scrollView == profileInformationCollectionView || scrollView == profileImagecollectionView {
            let point = CGPoint(x: profileInformationCollectionView.contentOffset.x, y: profileInformationCollectionView.contentOffset.y + profileInformationCollectionView.frame.height/2)
            if let indexPath = profileInformationCollectionView.indexPathForItem(at: point) {
                profileImagecollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                selectedIndex = indexPath.item
            }
        }
    }
}
