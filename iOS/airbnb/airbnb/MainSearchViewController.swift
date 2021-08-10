//
//  MainSearchViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/09.
//

import UIKit

class MainSearchViewController: UIViewController {

    weak var coordinator: MainSearchSceneFlowCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 필요한 ViewModel을 파라미터에 넘겨 ViewController를 초기화 해줘야 한다.
    static func create() -> MainSearchViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(identifier: "MainSearchViewController") as? MainSearchViewController else {
            return MainSearchViewController()
        }
        
        return viewController
    }
    
    func injectionCoordinator(coordinator: MainSearchSceneFlowCoordinator) {
        self.coordinator = coordinator
    }

    override func viewDidAppear(_ animated: Bool) {
        coordinator?.presentSignInViewController()
    }
    
}
