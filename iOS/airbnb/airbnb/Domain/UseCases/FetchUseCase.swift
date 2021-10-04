//
//  FetchMainPageUseCase.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/27.
//

import Foundation
import RxSwift
import simd

protocol FetchUseCase {
    associatedtype DataType: Decodable
    func executeWithRx() -> Observable<DataType>
}

class FetchMainPageUseCase: NSObject, FetchUseCase {
    
    typealias DataType = MainPage
    private let mainPageRepository: MainPageRepository
    
    init(with mainPageRepository: MainPageRepository) {
        self.mainPageRepository = mainPageRepository
    }
    
    func executeWithRx() -> Observable<DataType> {
        return mainPageRepository.fetchWithRx().map{$0.toDomain()}
    }
}
