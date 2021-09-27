//
//  FetchMainPageUseCase.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/27.
//

import Foundation

protocol FetchMainPageUseCase {
//    func execute(_ request: MainPageRequest, _ dataType: MainPageDTO.Type, completion: @escaping ((Result<MainPage, NetworkError>) -> Void))
    func execute(completion: @escaping ((Result<MainPage, NetworkError>) -> Void))
}

class DefaultFetchMainPageUseCase: FetchMainPageUseCase {

    private let mainPageRepository: MainPageRepository
    
    init(mainPageRepository: MainPageRepository) {
        self.mainPageRepository = mainPageRepository
    }
    
//    func execute(_ request: MainPageRequest, _ dataType: MainPageDTO.Type, completion: @escaping ((Result<MainPage, NetworkError>) -> Void)) {
//        mainPageRepository.fetchMainPage(request, dataType.self) { response in
//            switch response {
//            case .success(let mainPage):
//                completion(.success(mainPage))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
        func execute(completion: @escaping ((Result<MainPage, NetworkError>) -> Void)) {
            mainPageRepository.fetchMainPage() { response in
                switch response {
                case .success(let mainPage):
                    completion(.success(mainPage))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    

}
