//
//  FakeAF.swift
//  airbnbTests
//
//  Created by 심영민 on 2021/09/23.
//

import Foundation
@testable import Alamofire
@testable import airbnb
class FakeAF: SessionProtocol {
    var requestParameters: (
        url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters?
    )?
    
    func request(_ convertible: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?, interceptor: RequestInterceptor?, requestModifier: Session.RequestModifier?) -> DataRequest {
        
        self.requestParameters = (
            url: convertible,
            method: method,
            parameters: parameters
        )
        
        let convertible = Session.RequestConvertible(url: convertible,
                                             method: method,
                                             parameters: parameters,
                                             encoding: encoding,
                                             headers: headers,
                                             requestModifier: requestModifier)
        
        return Session().request(convertible, interceptor: interceptor)
    }
}
