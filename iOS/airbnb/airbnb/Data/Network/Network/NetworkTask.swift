//
//  NetworkService.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/09.
//

import Foundation
import Alamofire

class Task<Input, Output>  {
    func fetch(_ request: Input, _ dataType: Output.Type, completion: @escaping ((Result<Output,NetworkError>) -> Void)) {
        
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
    
    override func fetch(_ request: Input, _ dataType: Output.Type, completion: @escaping ((Result<Output, NetworkError>) -> Void)) {
        dispatcher.execute(request: request) { response in
            switch response {
            case .success(let data):
                do {
                    let result = try self.decoder.decode(dataType.self, from: data)
                    completion(.success(result))
                } catch {
                    // decoding Error
                    completion(.failure(NetworkError.failDecoding))
                }
                
            case .failure(_):
                // Network request Error
                print(NetworkError.invalidRequest)
            }
        }
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
    case invalidURL, failDecoding, invalidRequest
    
    var description: String {
        switch self {
        case .invalidURL:
            return "URL이 올바르지 않습니다."
        case .failDecoding:
            return "Decoding이 올바르지 않습니다."
        case .invalidRequest:
            return "네트워크 연결 상태를 확인하세요."
        }
    }
}
