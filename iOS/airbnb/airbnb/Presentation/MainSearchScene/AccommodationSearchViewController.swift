//
//  AccomodationSearchViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/16.
//

import UIKit
import MapKit

class AccommodationSearchViewController: UITableViewController, UISearchBarDelegate {
    weak var coordinator: MainSearchSceneFlowCoordinator?
    private var searchController: UISearchController!
    
    private var suggestionController: SearchSuggestionTableViewContrller!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSuggestionController()
        setupSearchController()
        self.tableView.tableHeaderView = makeTableHeaderView()
    }
    
    static func create() -> AccommodationSearchViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(identifier: "AccommodationSearchViewController") as? AccommodationSearchViewController else {
            return AccommodationSearchViewController()
        }
        return viewController
    }
    
    func setupSuggestionController() {
        self.suggestionController = SearchSuggestionTableViewContrller(style: .grouped)
    }
    
    func setupSearchController() {
        self.searchController = UISearchController(searchResultsController: suggestionController)
        self.searchController.searchResultsUpdater = suggestionController
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.placeholder = "어디로 여행가세요?"
        self.searchController.automaticallyShowsCancelButton = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func makeTableHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: 78)))
        let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 177, height: 22)))
        headerView.addSubview(label)
        label.text = "근처의 인기 여행지"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16).isActive = true
//        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 32).isActive = true
        label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -24).isActive = true
        label.font = .boldSystemFont(ofSize: 17)
        headerView.addSubview(label)
        return headerView
    }
    
    func injectionCoordinator(with coordinator: MainSearchSceneFlowCoordinator) {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.pushFindingAccommodationViewController()
    }
}
