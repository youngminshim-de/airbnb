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
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>
    
    weak var coordinator: MainSearchSceneFlowCoordinator?
    private lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applySnapshot()
        accommodationListCollectionView.dataSource = dataSource
        accommodationListCollectionView.delegate = self
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return 0
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//
//        // Configure the cell
//
//        return cell
//    }
}

extension AccommodationListCollectionViewController {
    func configureDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: accommodationListCollectionView) {
            (collectionView, indexPath, model) -> UICollectionViewCell in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccommodationListCell", for: indexPath) as? AccommodationListCell else {
                return AccommodationListCell()
            }
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AccommodationListHeader", for: indexPath) as? AccommodationListCell else {
                return nil
            }
            return view
        }
        return dataSource
    }
    
    func applySnapshot(animatingDifference: Bool = true) {
        var snapshot = Snapshot()
        
        snapshot.appendSections(Section.allCases)
        
        Section.allCases.forEach { section in
            snapshot.appendItems(["str"], toSection: section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifference)
    }
}

enum Section: CaseIterable {
    case main
}
