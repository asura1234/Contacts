//
//  ViewController.swift
//  Contacts
//
//  Created by Yang Liu on 1/3/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        // setup collection view delegates
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // Mark: Implement UICollectionViewDataSource
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileImageCell", for: indexPath)
        if let profileImageCell = cell as? ProfileImageCollectionViewCell {
            profileImageCell.profileImage.image = persons[indexPath.item].profileImage
        }
        return cell
    }
}

