//
//  UserService.swift
//  QRna
//
//  Created by 이명직 on 2021/10/04.
//

import Moya
import SwiftKeychainWrapper

public enum UserService {
    case signin(email: String, password: String, role: String)
    case signup(name: String, email: String, nickName: String, telNumber: String, password: String, role: String, zipcode: String, street: String, city: String)
    case getInfo
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
            print("/api/v1/users/withdraw/\(UserViewModel.id)/\(UserViewModel.role)")
            return "/api/v1/users/withdraw/\(UserViewModel.id)/\(UserViewModel.role)"
        case .logout:
            print("/api/v1/users/logout/\(UserViewModel.id)/\(UserViewModel.role)")
            return "/api/v1/users/logout/\(UserViewModel.id)/\(UserViewModel.role)"
        case .getInfo:
            return "/api/v1/users/page/\(UserViewModel.id)/\(UserViewModel.role)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .signin, .signup:
            return .post
        case .withdraw:
            return .delete
        case .logout, .getInfo:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .signin(email: let email, password: let password, role: let role):
            print("email : \(email) password : \(password)")
            return .requestCompositeParameters(bodyParameters: ["email" : email, "password" : password, "role": role], bodyEncoding: JSONEncoding.default, urlParameters: .init())
        case .signup(name: let name, email: let email, nickName: let nickName, telNumber: let telNumber, password: let password, role: let role, zipcode: let zipcode, street: let street, city: let city):
            print("[name : \(name), email : \(email), nickName : \(nickName), telNumber : \(telNumber), password : \(password), role : \(role), address:[zipcode:\(zipcode), street: \(street), city: \(city)]]")
            return .requestCompositeParameters(bodyParameters: ["name" : name, "email" : email, "nickName" : nickName, "telNumber" : telNumber, "password" : password, "role" : role, "address":["zipcode":zipcode, "street": street, "city": city]], bodyEncoding: JSONEncoding.default, urlParameters: .init())
        case .withdraw, .logout, .getInfo:
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
