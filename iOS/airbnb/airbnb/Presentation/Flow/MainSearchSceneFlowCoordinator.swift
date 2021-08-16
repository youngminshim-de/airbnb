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
}

class MainSearchSceneFlowCoordinator: Coordinator {
    var rootViewController: UIViewController
    private let dependencies: MainSearchSceneFlowCoordinatorDependencies
    
    init(navigationController: UINavigationController, dependencies: MainSearchSceneFlowCoordinatorDependencies) {
        self.rootViewController = navigationController
        self.dependencies = dependencies
    }
    
    func presentSignInViewController() {
        let signInViewController = dependencies.makeSignInViewController()
        signInViewController.modalPresentationStyle = .fullScreen
        rootViewController.present(signInViewController, animated: true, completion: nil)
    }
    
    func dismissSignInViewController(_ viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func start() {
        let mainSearchViewController = dependencies.makeMainSearchViewController()
        self.rootViewController = UINavigationController(rootViewController: mainSearchViewController)
        mainSearchViewController.injectionCoordinator(coordinator: self)
        self.rootViewController.tabBarItem = UITabBarItem(title: "검색", image: UIImage(named: "search.png"), tag: 0)
    }
}
