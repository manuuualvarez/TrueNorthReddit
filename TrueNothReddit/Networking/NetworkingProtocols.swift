//
//  NetworkingProtocols.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/21/22.
//

import Foundation
import Alamofire

typealias RequestSettings = ResourceProtocol


protocol ResourceProtocol {
    var url: String { get }
    var method: Alamofire.HTTPMethod { get }
    var encoding: ParameterEncoding { get }
}


struct RequestConfigurationFactory {
    enum EncodingType {
        case body, url
    }
    
    private static func getParameterEncoding(from type: EncodingType) -> ParameterEncoding {
        switch type {
            case .body:
                return JSONEncoding.default
            case .url:
                return URLEncoding.default
        }
    }
    

    static func createRequestSettings(encodingType: EncodingType,
                                      url: String,
                                      method: Alamofire.HTTPMethod) -> RequestSettings {
        return BaseResource(url: url, method: method, encoding: getParameterEncoding(from: encodingType))
    }
    
}

fileprivate struct BaseResource: ResourceProtocol {
    var url: String
    var method: HTTPMethod
    var encoding: ParameterEncoding

}


struct BasicResponse<T:Decodable>: Decodable {
    var success: Bool
    var data: T
}

struct BasicArrayResponse<T:Decodable>: Decodable {
    var success: Bool
    var data: [T]
}

struct ServiceError: Error, Equatable {
    var success: Bool
    var data: String
    
    static var genericError: ServiceError {
        return ServiceError(success: false, data: "Upppps, somethings wrong! ...")
    }
    
    init(success: Bool, data: String){
        self.success = success
        self.data = data
    }
    
}

