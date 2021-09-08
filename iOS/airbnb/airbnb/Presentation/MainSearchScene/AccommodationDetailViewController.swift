//
//  AccommodationDetailViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/08.
//

import UIKit

class AccommodationDetailViewController: UIViewController {
    
    weak var coordinator: MainSearchSceneFlowCoordinator?
    @IBOutlet weak var accommodationImageStackView: UIStackView!
    @IBOutlet weak var accommodationDetailView: AccommodationDetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccommodationDetailViewController()
    }
    
    static func create() -> AccommodationDetailViewController {
        let stroyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = stroyboard.instantiateViewController(identifier: "AccommodationDetailViewController") as?
                AccommodationDetailViewController else {
            return AccommodationDetailViewController()
        }
        return viewController
    }
    
    private func setupAccommodationDetailViewController() {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func injectionCoordinator(with coordinator: MainSearchSceneFlowCoordinator) {
        self.coordinator = coordinator
    }
}
