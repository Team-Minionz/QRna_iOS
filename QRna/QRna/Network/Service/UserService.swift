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
    case signup(name: String, email: String, nickName: String, telNumber: String, password: String, zipcode: String, street: String, city: String, latitude: Double, longitude: Double)
    case getInfo
    case withdraw
    case logout
    case bookMark(shopId: Int)
    case removeBookMark(shopId: Int)
    case searchStore(keyword: String)
    case searchStoreWithRegion(keyword: String, region: String)
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
            print("/api/v1/users/withdraw/\(UserViewModel.id)")
            return "/api/v1/users/withdraw/\(UserViewModel.id)"
        case .logout:
            print("/api/v1/users/logout/\(UserViewModel.id)")
            return "/api/v1/users/logout/\(UserViewModel.id)"
        case .getInfo:
            return "/api/v1/users/page/\(UserViewModel.id)"
        case .bookMark:
            return "/api/v1/users/bookmark"
        case .removeBookMark(let shopId):
            return "/api/v1/users/bookmark/\(UserViewModel.id)/\(shopId)"
        case .searchStore(let keyword):
            return "/api/v1/shops/search?keyword=\(keyword)"
        case .searchStoreWithRegion(let keyword, let region):
            return "/api/v1/shops/search/region?region=\(region)&keyword=\(keyword)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .signin, .signup, .bookMark:
            return .post
        case .withdraw, .removeBookMark:
            return .delete
        case .logout, .getInfo, .searchStore, .searchStoreWithRegion:
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
        case .signup(name: let name, email: let email, nickName: let nickName, telNumber: let telNumber, password: let password, zipcode: let zipcode, street: let street, city: let city, latitude: let latitude, longitude: let longitude):
            print("[name : \(name), email : \(email), nickName : \(nickName), telNumber : \(telNumber), password : \(password), address:[zipcode:\(zipcode), street: \(street), city: \(city), latitude: \(latitude), longitude: \(longitude)]]")
            return .requestCompositeParameters(bodyParameters: ["name" : name, "email" : email, "nickName" : nickName, "telNumber" : telNumber, "password" : password, "address":["zipcode":zipcode, "street": street, "city": city]], bodyEncoding: JSONEncoding.default, urlParameters: .init())
        case .bookMark(let shopId):
            return .requestCompositeParameters(bodyParameters: ["shopId":shopId, "userId":UserViewModel.id], bodyEncoding: JSONEncoding.default, urlParameters: .init())
        case .withdraw, .logout, .getInfo, .removeBookMark, .searchStore, .searchStoreWithRegion:
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
