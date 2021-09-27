//
//  NetworkDispatcher.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/19.
//

import Foundation
import Alamofire
import RxSwift

protocol NetworkDispatcher {
    func execute(request: Requestable, completion: @escaping (Result<Data, AFError>) -> Void)
}

class MainPageDispatcher: NetworkDispatcher {
    
    private var session: SessionProtocol
    
    init(with session: SessionProtocol) {
        self.session = session
    }
    
    func execute(request: Requestable, completion: @escaping (Result<Data, AFError>) -> Void) {
        
        guard let url = request.url() else {
            return
        }
        
        session.request(url, method: .get, parameters: nil, encoding: URLEncoding.default,
                        headers: nil, interceptor: nil, requestModifier: nil)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    completion(.success(data))
                }
            }
    }
}
