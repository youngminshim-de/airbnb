//
//  AccomodationSearchViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/16.
//

import UIKit

class AccommodationSearchViewController: UITableViewController, UISearchBarDelegate {
    weak var coordinator: MainSearchSceneFlowCoordinator?
    private var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
    }
    
    static func create() -> AccommodationSearchViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(identifier: "AccommodationSearchViewController") as? AccommodationSearchViewController else {
            return AccommodationSearchViewController()
        }
        return viewController
    }
    
    func setupSearchController() {
        self.searchController = UISearchController()
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.placeholder = "어디로 여행가세요?"
        self.searchController.automaticallyShowsCancelButton = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func injectionCoordinator(coordinator: MainSearchSceneFlowCoordinator) {
        self.coordinator = coordinator
    }
}

extension AccommodationSearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClosedPopulationTripPlaceCellTableViewCell", for: indexPath) as? ClosedPopulationTripPlaceCellTableViewCell else {
            return ClosedPopulationTripPlaceCellTableViewCell()
        }
        
        return cell
    }
}
