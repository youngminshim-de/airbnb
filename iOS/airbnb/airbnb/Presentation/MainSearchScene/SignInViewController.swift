//
//  ViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/07/29.
//

import UIKit

class SignInViewController: UIViewController {
    weak var coordinator: MainSearchSceneFlowCoordinator?
    private var oauthManager: OAuthManager!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.oauthManager = OAuthManager(parentViewController: self)
    }
    
    static func create() -> SignInViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyBoard.instantiateViewController(identifier: "SignInViewController") as? SignInViewController else {
            return SignInViewController()
        }
        return viewController
    }

    @IBAction func continueButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func githubButtonTouched(_ sender: UIButton) {
        oauthManager.excuteOAuth(with: .github) { result in
            switch result {
            case .success(_):
                print("success")
            case .failure(_):
                break
            }
        }
    }
}

