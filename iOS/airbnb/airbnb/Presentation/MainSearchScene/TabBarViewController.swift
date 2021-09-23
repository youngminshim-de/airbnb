//
//  TabBarViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/09.
//

import UIKit

class TabBarViewController: UITabBarController {

    var coordinator: AppFlowCoordinator!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UITabBar.appearance().barTintColor = .systemGray6
        UITabBar.appearance().tintColor = .black
    }
    
    func injectionCoordinator(with coordinator: AppFlowCoordinator) {
        self.coordinator = coordinator
    }
    
    func test() {
        var views: [UIViewController] = []
        coordinator.childCoordinator.forEach{
            views.append($0.rootViewController)
        }
        self.viewControllers = views
    }
    
}

