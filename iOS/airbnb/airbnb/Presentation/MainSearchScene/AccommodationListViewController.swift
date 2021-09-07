//
//  AccommodationListViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/07.
//

import UIKit

class AccommodationListViewController: UIViewController {

    @IBOutlet var accommodationListCollectionView: UICollectionView!
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>
    
    weak var coordinator: MainSearchSceneFlowCoordinator?
    private lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applySnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    static func create() -> AccommodationListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(identifier: "AccommodationListViewController") as? AccommodationListViewController else {
            return AccommodationListViewController()
        }
        return viewController
    }
    
    func injectionCoordinator(with coordinator: MainSearchSceneFlowCoordinator) {
        self.coordinator = coordinator
    }

    @IBAction func mapButtonTouched(_ sender: UIButton) {
    }
    
}

extension AccommodationListViewController {
    func configureDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: accommodationListCollectionView) {
            (collectionView, indexPath, model) -> UICollectionViewCell in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccommodationListCell", for: indexPath) as? AccommodationListCell else {
                return AccommodationListCell()
            }
            cell.configureCell()
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            
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
            snapshot.appendItems(["str", "asd", "asc"], toSection: section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifference)
    }
}

enum Section: CaseIterable {
    case main
}
