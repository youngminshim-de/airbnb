//
//  MainPageViewModel.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/28.
//

import Foundation

class MainPageViewModel {
    private let fetchMainPageUseCase: FetchMainPageUseCase
    private (set) var nearbyPlaces: [NearbyPlace]
    private (set) var themes: [Theme]
    
    init(_ fetchMainPageUseCase: FetchMainPageUseCase) {
        self.fetchMainPageUseCase = fetchMainPageUseCase
        self.nearbyPlaces = []
        self.themes = []
    }
    
    func fetchMainPage() {
        fetchMainPageUseCase.execute { response in
            switch response {
            case .success(let mainPage):
                self.nearbyPlaces = mainPage.nearbyPlaces
                self.themes = mainPage.themes
            case .failure(let error):
                print(error)
            }
        }
    }
}
