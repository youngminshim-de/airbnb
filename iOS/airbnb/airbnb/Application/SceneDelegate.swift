//
//  SceneDelegate.swift
//  airbnb
//
//  Created by 심영민 on 2021/07/29.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let appDIContainer = AppDIContainer()
    private var flowCoordinator: AppFlowCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let tabBarController = TabBarViewController()
        window?.rootViewController = tabBarController
        flowCoordinator = AppFlowCoordinator(tabBarController: tabBarController, appDIContainer: appDIContainer)
        flowCoordinator?.start()
        tabBarController.injectionCoordinator(with: flowCoordinator!)
        tabBarController.test()
        window?.makeKeyAndVisible()
    }
}

