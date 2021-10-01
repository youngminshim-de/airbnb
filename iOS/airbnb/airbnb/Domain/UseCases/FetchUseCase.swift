//
//  FetchMainPageUseCase.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/27.
//

import Foundation
import RxSwift

protocol FetchUseCase {
    associatedtype DataType: Decodable
//    func execute(_ request: MainPageRequest, _ dataType: MainPageDTO.Type, completion: @escaping ((Result<MainPage, NetworkError>) -> Void))
    func execute(completion: @escaping ((Result<DataType, NetworkError>) -> Void))
    func executeWithRx() -> Observable<DataType>
}

class FetchMainPageUseCase: FetchUseCase {
    
    typealias DataType = MainPage
    private let mainPageRepository: MainPageRepository
    private let disposeBag = DisposeBag()
    
    init(with mainPageRepository: MainPageRepository) {
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
            mainPageRepository.fetch() { response in
                switch response {
                case .success(let mainPage):
                    completion(.success(mainPage.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    
        func executeWithRx() -> Observable<DataType> {
            let eventer = PublishSubject<DataType>()
            mainPageRepository.fetchWithRx()
                .subscribe(onNext: { data in
                    eventer.onNext(data.toDomain())
                    eventer.onCompleted()
                }, onError: { error in
                    eventer.onError(error)
                })
                .disposed(by: disposeBag)
            
            return eventer
        }
}
