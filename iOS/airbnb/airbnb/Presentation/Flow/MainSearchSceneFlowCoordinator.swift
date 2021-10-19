//
//  MainSearchSceneFlowCoordinator.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/09.
//

import UIKit

protocol MainSearchSceneFlowCoordinatorDependencies {
    // 이 함수에 액션도 주입해줘야 한다. 페이지 넘어가는 액션
    func makeMainSearchViewController() -> MainSearchViewController
    func makeSignInViewController() -> SignInViewController
    func makeAccommodationSearchViewController() -> AccommodationSearchViewController
    func makeFindingAccommodationViewController() -> FindingAccommodationViewController
    func makeAccommodationListCollectionViewController() -> AccommodationListViewController
    func makeAccommodationDetailViewController() -> AccommodationDetailViewController
    func makeReservationViewController() -> ReservationViewController
}

class MainSearchSceneFlowCoordinator: ChildCoordinator {
    var rootViewController: UINavigationController
    private let dependencies: MainSearchSceneFlowCoordinatorDependencies
    
    init(navigationController: UINavigationController, dependencies: MainSearchSceneFlowCoordinatorDependencies) {
        self.rootViewController = navigationController
        self.dependencies = dependencies
    }
    
    func presentSignInViewController() {
        let signInViewController = dependencies.makeSignInViewController()
        signInViewController.modalPresentationStyle = .fullScreen
        rootViewController.children.first?.present(signInViewController, animated: true, completion: nil)
    }
    
    func pushAccomodationSearchViewController() {
        let accommodationSerachViewContoller = dependencies.makeAccommodationSearchViewController()
        accommodationSerachViewContoller.injectionCoordinator(with: self)
        rootViewController.pushViewController(accommodationSerachViewContoller, animated: true)
    }
    
    func dismissSignInViewController(_ viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func pushFindingAccommodationViewController() {
        let findingAccommodationViewController = dependencies.makeFindingAccommodationViewController()
        findingAccommodationViewController.injectionCoordinator(with: self)
        rootViewController.pushViewController(findingAccommodationViewController, animated: true)
    }
    
    func pushAccommodationListCollectionViewController() {
        let accommodationListCollectionViewController = dependencies.makeAccommodationListCollectionViewController()
        accommodationListCollectionViewController.injectionCoordinator(with: self)
        rootViewController.pushViewController(accommodationListCollectionViewController, animated: true)
    }
    
    func pushAccommodationDetailViewController() {
        let accommodationDetailViewController = dependencies.makeAccommodationDetailViewController()
        accommodationDetailViewController.injectionCoordinator(with: self)
        rootViewController.pushViewController(accommodationDetailViewController, animated: true)
    }
    
    func presentReservationViewController() {
        let reservationViewController = dependencies.makeReservationViewController()
        reservationViewController.injectionCoordinator(with: self)
        reservationViewController.modalPresentationStyle = .overCurrentContext
        rootViewController.present(reservationViewController, animated: true, completion: nil)
    }
    
    func popViewController() {
        rootViewController.popViewController(animated: true)
    }
    
    func presentAlertController(with message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        rootViewController.present(alertController, animated: false)
    }
    
    func start() {
        let mainSearchViewController = dependencies.makeMainSearchViewController()
        self.rootViewController = UINavigationController(rootViewController: mainSearchViewController)
        mainSearchViewController.injectionCoordinator(with: self)
        self.rootViewController.tabBarItem = UITabBarItem(title: "검색", image: UIImage(named: "search.png"), tag: 0)
    }
}
