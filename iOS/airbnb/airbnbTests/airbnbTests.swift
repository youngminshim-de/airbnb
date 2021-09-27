//
//  airbnbTests.swift
//  airbnbTests
//
//  Created by 심영민 on 2021/07/29.
//
@testable import airbnb
import XCTest
@testable import Alamofire


class airbnbTests: XCTestCase {

    func testNetwork_withoutInternet() {
        let fakeAF = FakeAF()
        let dispatcher = MainPageDispatcher(with: fakeAF)
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
        let param = fakeAF.requestParameters
        
        XCTAssertEqual(try param?.url.asURL().absoluteString, EndPoint.mainURL.description)
        
    }
}

