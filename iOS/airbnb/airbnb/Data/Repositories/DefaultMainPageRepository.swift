//
//  MainPageRepository.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/27.
//

import Foundation
import Alamofire

protocol MainPageRepository {
//    func fetchMainPage(_ request: MainPageRequest, _ dataType: MainPageDTO.Type, completion: @escaping ((Result<MainPage, NetworkError>) -> Void))
    func fetchMainPage(completion: @escaping ((Result<MainPage, NetworkError>) -> Void))
}

class DefaultMainPageRepository: MainPageRepository {
//    private let session: SessionProtocol
    private let networkTask: Task<MainPageRequest, MainPageDTO>
    
    init(with networkTask: Task<MainPageRequest, MainPageDTO>) {
        self.networkTask = networkTask
    }
    
//    func fetchMainPage(_ request: MainPageRequest, _ dataType: MainPageDTO.Type, completion: @escaping ((Result<MainPage,NetworkError>) -> Void)) {
//        networkTask.fetch(request, dataType.self) { response in
//            switch response {
//            case .success(let mainPage):
//                completion(.success(mainPage.toDomain()))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
    func fetchMainPage(completion: @escaping ((Result<MainPage,NetworkError>) -> Void)) {
        networkTask.fetch(MainPageRequest(path: EndPoint.mockURL.description, httpMethod: .get, bodyParams: nil, headers: nil), MainPageDTO.self) { response in
            switch response {
            case .success(let mainPage):
                completion(.success(mainPage.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
