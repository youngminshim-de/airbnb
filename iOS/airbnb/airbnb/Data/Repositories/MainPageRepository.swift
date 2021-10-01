//
//  MainPageRepository.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/27.
//

import Foundation
import Alamofire
import RxSwift

protocol Repository {
//    func fetchMainPage(_ request: MainPageRequest, _ dataType: MainPageDTO.Type, completion: @escaping ((Result<MainPage, NetworkError>) -> Void))
//    func fetchMainPage(completion: @escaping ((Result<MainPage, NetworkError>) -> Void))
    associatedtype DataType: Decodable
    func fetch(completion: @escaping ((Result<DataType, NetworkError>) -> Void))
    func fetchWithRx() -> Observable<DataType>
}

class MainPageRepository: Repository {
    
    typealias DataType = MainPageDTO
    private let networkTask: Task<MainPageRequest, DataType>
    private let disposeBag = DisposeBag()
    
    init(with networkTask: Task<MainPageRequest, DataType>) {
        self.networkTask = networkTask
    }
    
    func fetch(completion: @escaping ((Result<DataType, NetworkError>) -> Void)) {
        networkTask.fetch(MainPageRequest(path: EndPoint.mockURL.description, httpMethod: .get, bodyParams: nil, headers: nil), DataType.self) { response in
            switch response {
            case .success(let second):
                completion(.success(second))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchWithRx() -> Observable<DataType> {
        let eventer = PublishSubject<DataType>()
        networkTask.fetchWithRx(MainPageRequest(path: EndPoint.mockURL.description, httpMethod: .get, bodyParams: nil, headers: nil), DataType.self)
            .subscribe(onNext: { mainPageDTO in
                eventer.onNext(mainPageDTO)
                eventer.onCompleted()
            }, onError: { error in
                eventer.onError(error)
            })
            .disposed(by: disposeBag)
        return eventer
    }
    
//    private let session: SessionProtocol

//    refactor2
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
//    refactor3
//    func fetchMainPage(completion: @escaping ((Result<MainPage,NetworkError>) -> Void)) {
//        networkTask.fetch(MainPageRequest(path: EndPoint.mockURL.description, httpMethod: .get, bodyParams: nil, headers: nil), MainPageDTO.self) { response in
//            switch response {
//            case .success(let mainPage):
//                completion(.success(mainPage.toDomain()))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
}
