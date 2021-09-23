//
//  airbnbTests.swift
//  airbnbTests
//
//  Created by 심영민 on 2021/07/29.
//

import XCTest
@testable import airbnb
@testable import Alamofire

class airbnbTests: XCTestCase {

    func testNetwork() {
        let dispatcher: NetworkDispatcher = MainPageDispatcher(with: AF)
        let request = MainPageRequest(path: EndPoint.mainURL.description, httpMethod: .get, bodyParams: nil, headers: nil)
        let network: NetworkTask<MainPageRequest, MainPageDTO> = NetworkTask(with: dispatcher, with: JSONDecoder(), with: .convertFromSnakeCase)
        network.fetch(request, MainPageDTO.self) { response in
            switch response {
            case .failure(let error):
                print(error)
            case .success(let data):
                print(data)
            }
        }
    }
}
