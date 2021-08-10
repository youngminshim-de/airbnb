//
//  ViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/07/29.
//

import UIKit

class SignInViewController: UIViewController {
    weak var coordinator: MainSearchSceneFlowCoordinator?
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton()
    }
    
    static func create() -> SignInViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyBoard.instantiateViewController(identifier: "SignInViewController") as? SignInViewController else {
            return SignInViewController()
        }
        return viewController
    }

    @IBAction func loginButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

