//
//  OAuthManager.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/30.
//

import UIKit
import AuthenticationServices

class OAuthManager: NSObject, ASWebAuthenticationPresentationContextProviding {
    
    enum LoginType: CustomStringConvertible {
        var description: String {
            switch self {
            case .github:
                return "github"
            case .kakao:
                return "kakao"
            }
        }
        case kakao
        case github
    }
    
    private var parentViewController: UIViewController
    private (set) static var code: String = ""
    
    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return parentViewController.view.window ?? ASPresentationAnchor()
    }
    
    func excuteOAuth(with type: LoginType, completion: @escaping (Result<User,Error>) -> Void) {
        var webAuthSession: ASWebAuthenticationSession?
        
        let callbackUrlScheme = "airbnb"
        let url = URL(string: "https://github.com/login/oauth/authorize?client_id=f0d4d37dcd0ecd6cd157")
        
        // github url
        // kakao url
        
        webAuthSession = ASWebAuthenticationSession.init(url: url!, callbackURLScheme: callbackUrlScheme, completionHandler: { (callBack:URL?, error:Error?) in
            guard error == nil, let successURL = callBack else {
                print("실패")
                return
            }
            
            let oauthToken = NSURLComponents(string: (successURL.absoluteString))?.queryItems?.filter({$0.name == "code"}).first
            
            let tempString: String = "\(oauthToken!)"
            OAuthManager.code = tempString
//            "http://52.78.45.48:8080/api/oauth/userinfo?code=qwkhegqhjwegqhjwge&type=kakao"
//            "http://52.78.45.48:8080/api/oauth/userinfo?code=qwkhegqhjwegqhjwge&type=github"
            let urlurl: URL = URL(string: "http://d31a-49-163-156-81.ngrok.io/api/oauth/userInfo?\(tempString)&type=github")!
            var request: URLRequest = URLRequest(url: urlurl)
            request.httpMethod = "GET"

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let user = try? JSONDecoder().decode(User.self, from: data!) else {
                    return
                }
                
                StorageManager.shared.deleteUser()
                let _ = StorageManager.shared.createUser(user)

                if StorageManager.shared.readUser() != nil {
                    DispatchQueue.main.async {
                        completion(.success(user))
                    }
                } else {
                    completion(.failure(error!))
                }
            }.resume()
        })
        
        webAuthSession?.presentationContextProvider = self
        webAuthSession?.start()
    }
}
