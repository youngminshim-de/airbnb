//
//  AccomodationSearchViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/16.
//

import UIKit

class AccommodationSearchViewController: UITableViewController {
    weak var coordinator: MainSearchSceneFlowCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func create() -> AccommodationSearchViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(identifier: "AccommodationSearchViewController") as? AccommodationSearchViewController else {
            return AccommodationSearchViewController()
        }
        return viewController
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
