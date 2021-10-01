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
    private (set) var disposableBag = DisposeBag()
    
    var mainPage: Observable<MainPage> {
        let eventer = PublishSubject<MainPage>()
        fetchMainPageUseCase.executeWithRx()
            .subscribe(onNext: { data in
                eventer.onNext(data)
            }, onError: { error in
                eventer.onError(error)
            })
            .disposed(by: disposableBag)
        return eventer
    }
    
    init(with fetchMainPageUseCase: FetchMainPageUseCase) {
        self.fetchMainPageUseCase = fetchMainPageUseCase
    }
    
//    func request() {
//        fetchMainPageUseCase.execute { response in
//            switch response {
//            case .success(let mainPage):
//                self.mainPage = mainPage
//            case .failure(let error):
//                self.errorMessage = "\(error)"
//            }
//        }
//    }

}
