//
//  AppDIContainer.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/09.
//

import Foundation
import Alamofire

class AppDIContainer {
    var apiNetworkService: NetworkTask<Requestable, Decodable> = NetworkTask(with: MainPageRequest(path: <#T##String#>, httpMethod: <#T##HTTPMethod#>, bodyParams: <#T##[String : Any]?#>, headers: <#T##[String : String]?#>), with: <#T##JSONDecoder#>, with: <#T##JSONDecoder.KeyDecodingStrategy#>)
    
    func makeMainSearchSceneDIContainer() -> MainSearchSceneDIContainer {
        let dependencies = MainSearchSceneDIContainer.Dependencies.init(apiNetworkService: apiNetworkService)
        // 의존성 주입해줘야한다. 네트워크 같은거
        return MainSearchSceneDIContainer(dependencies: dependencies)
    }
    
}
