//
//  OwnerDataService.swift
//  QRna
//
//  Created by 이명직 on 2021/10/19.
//

import Foundation
import Moya

class OwnerDataService {
    let service = MoyaProvider<OwnerService>()
    
    func requestAddStore(name: String, zipcode: String, street: String, city: String, telNumber: String, completion: @escaping (ResponseData?, Error?)->Void) {
        service.request(.addStore(name: name, zipcode: zipcode, street: street, city: city, telNumber: telNumber)) { request in
            
            switch request {
            case .success(let addStoreData):
                do {
                    if addStoreData.statusCode == 200 {
                        let data = ResponseData(message: "매장 등록 성공")
                        
                        completion(data, nil)
                    }
                    else {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(ResponseData.self, from: addStoreData.data)
                        
                        completion(data, nil)
                    }
                }
                catch(let error) {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
            
        }
    }
}
