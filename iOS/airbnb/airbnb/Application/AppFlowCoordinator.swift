//
//  AppFlowCoordinator.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/09.
//

import UIKit

protocol ChildCoordinator {
    var rootViewController: UINavigationController{ get }
    func start()
}

protocol Coordinator {
    var rootViewController: UIViewController { get }
    func start()
}

class AppFlowCoordinator: Coordinator {
    var rootViewController: UIViewController
    internal let appDIContainer: AppDIContainer
    var childCoordinator: [ChildCoordinator] = []
    
    init(tabBarController: UITabBarController, appDIContainer: AppDIContainer) {
        self.rootViewController = tabBarController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let mainSearchSceneDIContainer = appDIContainer.makeMainSearchSceneDIContainer()
        let flow = mainSearchSceneDIContainer.makeMainSearchSceneFlowCoordinator(navigationController: UINavigationController())
        flow.start()
        
        childCoordinator.append(flow)
        
        // 여기에 나머지 탭을 초기화한다.
        // appDIContainer에서는 나머지 Scene의 DIContainer를 초기화하는 메서드를 만든다.
        // 각 DIContainer는 자신의 FlowCoordinator를 초기화한다.
    }
}
