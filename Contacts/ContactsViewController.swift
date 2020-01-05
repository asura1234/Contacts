//
//  ViewController.swift
//  Contacts
//
//  Created by Yang Liu on 1/3/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var profileImagecollectionView: UICollectionView!
    @IBOutlet weak var profileInformationCollectionView: UICollectionView!
    
    var persons: [ContactPerson] = []
    var selectedIndex: Int = 0
    var profileImageCellSize: CGFloat = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the title on the navigation bar
        navigationItem.title = "Contacts"
        // deserialize the contacts.json file to an array of ContactPerson Objects
        if let path = Resources.contactsJsonPath, let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            let decoder = JSONDecoder()
            if let persons = try? decoder.decode([ContactPerson].self, from: data) {
                self.persons = persons
            }
        }
        // setup profile image collection view
        profileImagecollectionView.delegate = self
        profileImagecollectionView.dataSource = self
        profileImagecollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [.centeredHorizontally])
        profileImagecollectionView.isPagingEnabled = false
        let profileImageLayout = ProfileImageCollectionLayout()
        profileImageLayout.scrollDirection = .horizontal
        profileImageLayout.itemSize = CGSize(width: 80, height: 80)
        profileImageLayout.minimumLineSpacing = 10
        profileImageLayout.sectionInset = UIEdgeInsets(top: 0,left: padding ,bottom: 0,right: padding)
        profileImagecollectionView.collectionViewLayout = profileImageLayout
        
        // setup profile information collection view
        profileInformationCollectionView.delegate = self
        profileInformationCollectionView.dataSource = self
        profileInformationCollectionView.allowsSelection = false
        profileInformationCollectionView.isPagingEnabled = true
        let profileInformationLayout = UICollectionViewFlowLayout()
        profileInformationLayout.scrollDirection = .vertical
        profileInformationLayout.itemSize = profileInformationCollectionView.frame.size
        profileInformationLayout.minimumLineSpacing = 0
        profileInformationLayout.minimumInteritemSpacing = 0
        profileInformationLayout.sectionInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        profileInformationCollectionView.collectionViewLayout = profileInformationLayout
    }
    
    // Mark: Implement UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let person = persons[indexPath.item]
        if collectionView == profileImagecollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileImageCell", for: indexPath)
            if let profileImageCell = cell as? ProfileImageCollectionViewCell {
                profileImageCell.profileImage.image = person.profileImage
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileInformationCell", for: indexPath)
            
            if let profileInformationCell = cell as?
                ProfileInformationCollectionViewCell {

                let attributedName = NSMutableAttributedString(string: person.first_name + " " + person.last_name);
                
                let boldFont = UIFont.boldSystemFont(ofSize: 24)
                attributedName.addAttribute(.font, value: boldFont, range: NSRange(location: 0, length: person.first_name.count))
                
                let thinFont = UIFont(name: "HelveticaNeue-Light", size: 24) ?? UIFont.systemFont(ofSize: 24)
                attributedName.addAttribute(.font, value: thinFont, range: NSRange(location: person.first_name.count + 1, length: person.last_name.count))

                profileInformationCell.nameLabel.attributedText = attributedName
                profileInformationCell.titleLabel.text = person.title
                profileInformationCell.introductionLabel.text = person.introduction
            }
            return cell
        }
    }
    
    // Mark: Implement UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        profileImagecollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [.centeredHorizontally])
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == profileInformationCollectionView || scrollView == profileImagecollectionView {
            let point = CGPoint(x: profileInformationCollectionView.contentOffset.x, y: profileInformationCollectionView.contentOffset.y + profileInformationCollectionView.frame.height/2)
            if let indexPath = profileInformationCollectionView.indexPathForItem(at: point) {
                profileImagecollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            }
        }
    }
    
    private lazy var padding = (profileImagecollectionView.frame.size.width - profileImageCellSize)/2
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == profileImagecollectionView {
            let percentage = profileImagecollectionView.contentOffset.x / (profileImagecollectionView.contentSize.width - 2*padding + 20)
            let y = profileInformationCollectionView.contentSize.height * percentage
            profileInformationCollectionView.contentOffset = CGPoint(x: 0, y: y)
        }
        
        if scrollView == profileInformationCollectionView {
            let percentage = profileInformationCollectionView.contentOffset.y / profileInformationCollectionView.contentSize.height
            let x = (profileImagecollectionView.contentSize.width - 2*padding +  20) * percentage
            profileImagecollectionView.contentOffset = CGPoint(x: x, y: 0)
        }
    }
}

