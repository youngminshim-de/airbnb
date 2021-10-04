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
    associatedtype DataType: Decodable
    func fetchWithRx() -> Observable<DataType>
}

class MainPageRepository: NSObject, Repository {
    
    typealias DataType = MainPageDTO
    private let networkTask: Task<MainPageRequest, DataType>
    
    init(with networkTask: Task<MainPageRequest, DataType>) {
        self.networkTask = networkTask
    }
    
    func fetchWithRx() -> Observable<DataType> {
        return networkTask.fetchWithRx(MainPageRequest(path: EndPoint.mockURL.description, httpMethod: .get, bodyParams: nil, headers: nil), DataType.self)
    }
}
