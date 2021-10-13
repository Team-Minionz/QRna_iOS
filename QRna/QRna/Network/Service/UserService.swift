//
//  UserService.swift
//  QRna
//
//  Created by 이명직 on 2021/10/04.
//

import Moya
import SwiftKeychainWrapper

public enum UserService {
    case signin(email: String, password: String)
    case signup(name: String, email: String, nickName: String, telNumber: String, password: String)
    case withdraw
    case logout
}

extension UserService: TargetType {
    public var baseURL: URL {
        return URL(string: NetworkController.baseUrl)!
    }
    
    public var path: String {
        switch self {
        case .signin:
            return "/api/v1/users/login"
        case .signup:
            return "/api/v1/users/join"
        case .withdraw:
            print("/api/v1/users/withdraw/\(UserViewModel.userEmail)")
            return "/api/v1/users/withdraw/\(UserViewModel.userEmail)"
        case .logout:
            print("/api/v1/users/logout/\(UserViewModel.userEmail)")
            return "/api/v1/users/logout/\(UserViewModel.userEmail)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .signin, .signup:
            return .post
        case .withdraw:
            return .delete
        case .logout:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .signin(email: let email, password: let password):
            print("email : \(email) password : \(password)")
            return .requestCompositeParameters(bodyParameters: ["email" : email, "password" : password], bodyEncoding: JSONEncoding.default, urlParameters: .init())
        case .signup(name: let name, email: let email, nickName: let nickName, telNumber: let telNumber, password: let password):
            print("email : \(email) password : \(password)")
            return .requestCompositeParameters(bodyParameters: ["name" : name, "email" : email, "nickName" : nickName, "telNumber" : telNumber, "password" : password], bodyEncoding: JSONEncoding.default, urlParameters: .init())
        case .withdraw, .logout:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    
}
