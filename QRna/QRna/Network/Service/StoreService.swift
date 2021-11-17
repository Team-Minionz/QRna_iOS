//
//  StoreService.swift
//  QRna
//
//  Created by 이명직 on 2021/10/22.
//

import Foundation
import Moya

public enum StoreService {
    case getStoreList(latitude: Double, longitude: Double)
    case deleteStore(storeId: Int)
    case addStore(name: String, zipcode: String, street: String, city: String, telNumber: String, tableList: [[String:Any]])
    case getDetailTableInfo(storeId: Int)
    case exitTable(tableId: Int)
    case getStoreDetail(storeId: Int)
}

extension StoreService : TargetType {
    public var baseURL: URL {
        return URL(string: NetworkController.baseUrl)!
    }
    
    public var path: String {
        switch self {
        case .getStoreList:
            return "/api/v1/shops/near"
        case .deleteStore(let storeId):
            print("/api/v1/shops/\(storeId)")
            return "/api/v1/shops/\(storeId)"
        case .addStore:
            return "/api/v1/shops"
        case .getDetailTableInfo(let storeId):
            print("/api/v1/shops/\(storeId)")
            return "/api/v1/shops/\(storeId)"
        case .exitTable(let tableId):
            return "/api/v1/tables/\(tableId)"
        case .getStoreDetail(let storeId):
            return "/api/v1/shops/detail/\(storeId)/\(UserViewModel.id)"
            
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getStoreList, .getDetailTableInfo, .exitTable, .getStoreDetail:
            return .get
        case .deleteStore:
            return .delete
        case .addStore:
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .deleteStore, .getDetailTableInfo, .exitTable, .getStoreDetail:
            return .requestPlain
        case .addStore(name: let name, zipcode: let zipcode, street: let street, city: let city, telNumber: let telNumber, tableList: let tableList):
            print("\(OwnerViewModel.id)")
            return .requestCompositeParameters(bodyParameters: ["ownerId": OwnerViewModel.id, "name": name, "address": ["zipcode":zipcode, "street": street, "city": city, "latitude": 27.0, "longitude": 204.0], "telNumber": telNumber, "tableList": tableList], bodyEncoding: JSONEncoding.default, urlParameters: .init())
        case .getStoreList(let latitude, let longitude):
            return .requestParameters(parameters: ["latitude":latitude, "longitude":longitude], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    
}
