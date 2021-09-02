//
//  AccommodationListCollectionViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/02.
//

import UIKit

private let reuseIdentifier = "Cell"

class AccommodationListCollectionViewController: UICollectionViewController {

    @IBOutlet var accommodationListCollectionView: UICollectionView!
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
    
    weak var coordinator: MainSearchSceneFlowCoordinator?
    private var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    static func create() -> AccommodationListCollectionViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(identifier: "AccommodationListCollectionViewController") as? AccommodationListCollectionViewController else {
            return AccommodationListCollectionViewController()
        }
        return viewController
    }
    
    func injectionCoordinator(with coordinator: MainSearchSceneFlowCoordinator) {
        self.coordinator = coordinator
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
}

enum Section: CaseIterable {
    case main
}
