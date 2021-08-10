//
//  AppDIContainer.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/09.
//

import Foundation

class AppDIContainer {
    var apiNetworkService = DefaultNetworkService()
    
    func makeMainSearchSceneDIContainer() -> MainSearchSceneDIContainer {
        let dependencies = MainSearchSceneDIContainer.Dependencies.init(apiNetworkService: apiNetworkService)
        // 의존성 주입해줘야한다. 네트워크 같은거
        return MainSearchSceneDIContainer(dependencies: dependencies)
    }
    
}
