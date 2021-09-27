//
//  Requestable.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/19.
//

import Foundation
import Alamofire

protocol Requestable {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var bodyParams: [String: Any]? { get }
    var headers: [String: String]? { get }
    func url() -> URL?
}

class MainPageRequest: Requestable {
    var path: String
    var httpMethod: HTTPMethod
    var bodyParams: [String : Any]?
    var headers: [String : String]?
    
    init(path: String, httpMethod: HTTPMethod, bodyParams: [String: Any]? = nil, headers: [String: String]? = nil) {
        self.path = path
        self.httpMethod = httpMethod
    }
    
    func url() -> URL? {
        return URL(string: path)
    }
}

enum EndPoint: CustomStringConvertible {
    case mainURL
    case accommodationListURL
    case detailedAccommodationURL
    case mockURL
    var description: String {
        switch self {
        case .mainURL:
            return "url/api/main"
        case .accommodationListURL:
            return "url/api/accommodations"
        case .detailedAccommodationURL:
            return "url/api/"
        case .mockURL:
            return "https://dadff59e-9285-4889-83fa-945917b01911.mock.pstmn.io/api/main"
        }
    }
}
