//
//  NetworkService.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/09.
//

import Foundation
import RxSwift
import Alamofire
import NSObject_Rx

class Task<Input, Output>: NSObject  {
    func fetchWithRx(_ request: Input, _ dataType: Output.Type) -> Observable<Output> {
        return Observable.create { observer in
            return Disposables.create() }
    }
}

class NetworkTask<Input: Requestable, Output: Decodable>: Task<Input, Output> {
    private var dispatcher: NetworkDispatcher
    private var decoder: JSONDecoder
    
    init(with dispatcher: NetworkDispatcher, with decoder: JSONDecoder, with keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy) {
        self.dispatcher = dispatcher
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = keyDecodingStrategy
    }
    
    override func fetchWithRx(_ request: Input, _ dataType: Output.Type) -> Observable<Output> {
        let eventer = PublishSubject<Output>()
        
        dispatcher.executeWithRxSwift(request: request).subscribe(onNext: { [weak self] data in
            do {
                let result = try (self?.decoder.decode(dataType.self, from: data))!
                eventer.onNext(result)
                eventer.onCompleted()
            } catch {
                eventer.onError(NetworkError.failedDecoding)
            }
        }).disposed(by: rx.disposeBag)

        return eventer
    }
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
