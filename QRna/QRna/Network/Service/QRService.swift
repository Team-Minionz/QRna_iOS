//
//  QRService.swift
//  QRna
//
//  Created by 이명직 on 2021/10/05.
//

import Foundation
import Moya

enum QRService {
    case certification(userEmail: String, tableId: Int)
}

extension QRService: TargetType {
    var baseURL: URL {
        return URL(string: NetworkController.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .certification:
            return "/api/v1/visits"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .certification:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .certification(let userEmail, let tableId):
            print("email : \(userEmail)  shopTelNumber : \(tableId)")
            return .requestCompositeParameters(bodyParameters: ["userEmail" : userEmail, "tableId" : tableId], bodyEncoding: JSONEncoding.default, urlParameters: .init())
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    
}
