//
//  MainPageViewModel.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/28.
//

import Foundation
import RxSwift

class MainPageViewModel {
    private let fetchMainPageUseCase: FetchMainPageUseCase
    
    internal var mainPage: Observable<MainPage> {
        return fetchMainPageUseCase.executeWithRx()
    }
    
    init(with fetchMainPageUseCase: FetchMainPageUseCase) {
        self.fetchMainPageUseCase = fetchMainPageUseCase
    }
}
