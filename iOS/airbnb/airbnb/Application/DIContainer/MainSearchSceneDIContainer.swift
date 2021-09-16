//
//  MainSearchSceneDIContainer.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/09.
//

import UIKit

class MainSearchSceneDIContainer: MainSearchSceneFlowCoordinatorDependencies {

    struct Dependencies {
        let apiNetworkService: NetworkService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Repository
    // 네트워크 포함
    
    // MARK: - Use Cases
    // Repository 포함
    
    // MARK: - ViewModel
    // ViewModel초기화 할때 action이 포함
    
    // MARK: - ViewController
    func makeMainSearchViewController() -> MainSearchViewController {
        return MainSearchViewController.create()
    }
    
    // MARK: - FlowCoordinator
    func makeMainSearchSceneFlowCoordinator(navigationController: UINavigationController) -> MainSearchSceneFlowCoordinator {
        return MainSearchSceneFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension MainSearchSceneDIContainer {
    func makeSignInViewController() -> SignInViewController {
        return SignInViewController.create()
    }
}

extension MainSearchSceneDIContainer {
    func makeAccommodationSearchViewController() -> AccommodationSearchViewController {
        return AccommodationSearchViewController.create()
    }
}

extension MainSearchSceneDIContainer {
    func makeFindingAccommodationViewController() -> FindingAccommodationViewController {
        return FindingAccommodationViewController.create()
    }
}

extension MainSearchSceneDIContainer {
    func makeAccommodationListCollectionViewController() -> AccommodationListViewController {
        return AccommodationListViewController.create()
    }
}

extension MainSearchSceneDIContainer {
    func makeAccommodationDetailViewController() -> AccommodationDetailViewController {
        return AccommodationDetailViewController.create()
    }
}

extension MainSearchSceneDIContainer {
    func makeReservationViewController() -> ReservationViewController {
        return ReservationViewController.create()
    }
}
