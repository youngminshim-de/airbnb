//
//  NetworkService.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/09.
//

import Foundation
import Alamofire

class Task<Input, Output>  {
    func fetch(_ element: Input, _ dataType: Output, completion: @escaping ((Result<Output,AFError>) -> Void)) {
        
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
    
    func fetch(_ request: Input, _ dataType: Output.Type, completion: @escaping ((Result<Output, AFError>) -> Void)) {
        dispatcher.execute(request: request) { response in
            switch response {
            case .success(let data):
                do {
                    let result = try self.decoder.decode(dataType.self, from: data)
                    completion(.success(result))
                } catch {
                    // decoding Error
                    completion(.failure(AFError.createURLRequestFailed(error: error)))
                }
                
            case .failure(let error):
                // Network request Error
                print(error)
            }
        }
    }
}
