//
//  OwnerService.swift
//  QRna
//
//  Created by 이명직 on 2021/10/19.
//

import Foundation
import Moya

public enum OwnerService {
    case addStore(name: String, zipcode: String, street: String, city: String, telNumber: String)
}

extension OwnerService: TargetType {
    public var baseURL: URL {
        return URL(string: NetworkController.baseUrl)!
    }
    
    public var path: String {
        switch self {
        case .addStore:
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .addStore:
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .addStore(let name, let zipcode, let street, let city, let telNumber):
            return .requestCompositeParameters(bodyParameters: ["name":name, "zipcode" : zipcode, "street":street, "city": city, "telNumber" : telNumber], bodyEncoding: JSONEncoding.default, urlParameters: .init())
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    
}
