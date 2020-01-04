//
//  ViewController.swift
//  Contacts
//
//  Created by Yang Liu on 1/3/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var profileImagecollectionView: UICollectionView!
    
    
    @IBOutlet weak var profileInformationCollectionView: UICollectionView!
    
    var persons: [ContactPerson] = []
    var selectedIndex: Int = 0
    
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
        // setup collection view datasource and delegate
        profileImagecollectionView.delegate = self
        profileImagecollectionView.dataSource = self
        profileInformationCollectionView.delegate = self
        profileInformationCollectionView.dataSource = self
        profileInformationCollectionView.allowsSelection = false
        profileInformationCollectionView.isPagingEnabled = true
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
                profileInformationCell.contentView.frame = profileInformationCollectionView.bounds
                
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
        if collectionView == profileImagecollectionView {
            collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally], animated: true)
            selectedIndex = indexPath.item
        }
    }
}

