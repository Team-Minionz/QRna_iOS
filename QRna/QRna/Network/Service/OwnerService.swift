//
//  OwnerService.swift
//  QRna
//
//  Created by 이명직 on 2021/11/08.
//

import Foundation
import Moya

enum OwnerService {
    case signin(email: String, password: String)
    case signup(name: String, email: String, nickName: String, telNumber: String, password: String)
    case getInfo
    case withdraw
    case logout
    case findStoreByOwnerId
}

extension OwnerService: TargetType {
    var baseURL: URL {
        return URL(string: NetworkController.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .signin:
            return "/api/v1/owners/login"
        case .signup:
            return "/api/v1/owners/join"
        case .withdraw:
            print("/api/v1/owners/withdraw/\(OwnerViewModel.id)")
            return "/api/v1/owners/withdraw/\(OwnerViewModel.id)"
        case .logout:
            print("/api/v1/owners/logout/\(OwnerViewModel.id)")
            return "/api/v1/owners/logout/\(OwnerViewModel.id)"
        case .getInfo:
            return "/api/v1/owners/page/\(OwnerViewModel.id)"
        case .findStoreByOwnerId:
            return "/api/v1/owners/\(OwnerViewModel.id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signin, .signup:
            return .post
        case .withdraw:
            return .delete
        case .logout, .getInfo, .findStoreByOwnerId:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .signin(email: let email, password: let password):
            print("email : \(email) password : \(password)")
            return .requestCompositeParameters(bodyParameters: ["email" : email, "password" : password], bodyEncoding: JSONEncoding.default, urlParameters: .init())
        case .signup(name: let name, email: let email, nickName: let nickName, telNumber: let telNumber, password: let password):
            print("[name : \(name), email : \(email), nickName : \(nickName), telNumber : \(telNumber), password : \(password)]")
            return .requestCompositeParameters(bodyParameters: ["name" : name, "email" : email, "nickName" : nickName, "telNumber" : telNumber, "password" : password], bodyEncoding: JSONEncoding.default, urlParameters: .init())
       
        case .withdraw, .logout, .getInfo, .findStoreByOwnerId:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
