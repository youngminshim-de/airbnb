//
//  NetworkService.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/09.
//

import Foundation
import Alamofire

protocol NetworkManager  {
    
}

class MainNetworManager: NetworkManager {
    private var manager: SessionProtocol
    private var decoder: JSONDecoder
    
    init(with manager: SessionProtocol, with decoder: JSONDecoder) {
        self.manager = manager
        self.decoder = decoder
    }
}
