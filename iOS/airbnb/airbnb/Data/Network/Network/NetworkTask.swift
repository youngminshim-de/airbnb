//
//  NetworkService.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/09.
//

import Foundation
import RxSwift
import Alamofire

class Task<Input, Output>  {
    func fetch(_ request: Input, _ dataType: Output.Type, completion: @escaping ((Result<Output,NetworkError>) -> Void)) {}
    func fetchWithRx(_ request: Input, _ dataType: Output.Type) -> Observable<Output> {
        return Observable.create { observer in
            return Disposables.create() }
    }
}

class NetworkTask<Input: Requestable, Output: Decodable>: Task<Input, Output> {
    private var dispatcher: NetworkDispatcher
    private var decoder: JSONDecoder
    private let disposebag = DisposeBag()
    
    init(with dispatcher: NetworkDispatcher, with decoder: JSONDecoder, with keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy) {
        self.dispatcher = dispatcher
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = keyDecodingStrategy
    }
    
    override func fetch(_ request: Input, _ dataType: Output.Type, completion: @escaping ((Result<Output, NetworkError>) -> Void)) {
        dispatcher.execute(request: request) { response in
            switch response {
            case .success(let data):
                do {
                    let result = try self.decoder.decode(dataType.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(NetworkError.failedDecoding))
                }
                
            case .failure(_):
                print(NetworkError.invalidRequest)
            }
        }
    }
    
    override func fetchWithRx(_ request: Input, _ dataType: Output.Type) -> Observable<Output> {
        
        let eventer = PublishSubject<Output>() //지역변수로 놔둬도 됨
        dispatcher.executeWithRxSwift(request: request).subscribe(onNext: { [weak self] data in
            do {
                let result = try (self?.decoder.decode(dataType.self, from: data))!
                eventer.onNext(result)
                eventer.onCompleted()
            } catch {
                eventer.onError(NetworkError.failedDecoding)
            }
        }).disposed(by: disposebag)
        
        return eventer
        
//        return Observable.create { [weak self] observer in
//            self?.dispatcher.execute(request: request) { response in
//                switch response {
//                case .success(let data):
//                    do {
//                        let result = try (self?.decoder.decode(dataType.self, from: data))!
//                        observer.onNext(result)
//                        observer.onCompleted()
//                    } catch {
//                        observer.onError(NetworkError.failDecoding)
//                    }
//
//                case .failure(_):
//                    observer.onError(NetworkError.invalidRequest)
//                }
//            }
//            return Disposables.create()
//        }
    }
    
//    override func fetch(_ request: Input, _ dataType: Output.Type, completion: @escaping ((Result<Output, NetworkError>) -> Void)) {
//        dispatcher.execute(request: request) { response in
//            switch response {
//            case .success(let data):
//                do {
//                    let result = try self.decoder.decode(dataType.self, from: data)
//                    completion(.success(result))
//                } catch {
//                    // decoding Error
//                    completion(.failure(NetworkError.failDecoding))
//                }
//
//            case .failure(let error):
//                // Network request Error
//                print(NetworkError.invalidRequest)
//            }
//        }
//    }
}

enum NetworkError: Error, CustomStringConvertible {
    case invalidURL, failedDecoding, invalidRequest
    
    var description: String {
        switch self {
        case .invalidURL:
            return "URL이 올바르지 않습니다."
        case .failedDecoding:
            return "Decoding이 올바르지 않습니다."
        case .invalidRequest:
            return "네트워크 연결 상태를 확인하세요."
        }
    }
}
