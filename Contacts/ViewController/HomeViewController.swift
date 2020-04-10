//
//  HomeViewController.swift
//  Contacts
//
//  Created by Yang Liu on 4/10/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var profiles: [Profile] = [] {
        didSet {
            imageCollectionVC.profiles = profiles
            infoCollectionVC.profiles = profiles
        }
    }
    
    @IBOutlet weak var imageCollectionVIew: UIView!
    @IBOutlet weak var infoCollectionView: UIView!
    
    private lazy var imageCollectionVC  : ImageCollectionViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(identifier: "ImageCollectionViewController") as! ImageCollectionViewController
        self.add(asChildViewController: viewController, to: imageCollectionVIew)
        viewController.syncScrollingDelegate = self
        return viewController
    }()
    
    private lazy var infoCollectionVC: InfoCollectionViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(identifier: "InfoCollectionViewController") as! InfoCollectionViewController
        self.add(asChildViewController: viewController, to: infoCollectionView)
        viewController.syncScrollingDelegate = self
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the title on the navigation bar
        navigationItem.title = "Contacts"
        
        self.fetchData()
    }
    
    func fetchData() {
        if let path = Bundle.main.path(forResource: "contacts", ofType: "json"), let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            let decoder = JSONDecoder()
            if let profiles = try? decoder.decode([Profile].self, from: data) {
                self.profiles = profiles
            } else {
                preconditionFailure("Not able to decode contacts.json file. ")
            }
        } else {
            preconditionFailure("Not able to locate contacts.json file in the bundle.")
        }
    }
}

extension HomeViewController: SynchronizedScrollingDelegate {
    func didScroll(sender: UIViewController, contentOffsetRatio: CGFloat) {
        if sender == imageCollectionVC {
            infoCollectionVC.contentOffSetRatio = contentOffsetRatio
        }
        if sender == infoCollectionVC {
            imageCollectionVC.contentOffSetRatio = contentOffsetRatio
        }
    }
    
    func didSelect(sender: UIViewController, selectedIndex: Int) {
        if sender == infoCollectionVC {
            imageCollectionVC.selectedIndex = selectedIndex
        }
    }
}
