//
//  StoreDataService.swift
//  QRna
//
//  Created by 이명직 on 2021/10/22.
//

import Foundation
import Moya

class StoreDataService {
    let provider = MoyaProvider<StoreService>()
    
    func requestGetSotreList(completion: @escaping ([StoreInfo]?, Error?) -> Void) {
        provider.request(.getStoreList) { response in
            print("StoreDataService - requestGetSotreList")
            switch response {
            case .success(let getStoreData) :
                do {
                    print(getStoreData)
                    let decoder = JSONDecoder()
                    let data = try decoder.decode([StoreInfo].self, from: getStoreData.data)
                    print("파싱 성공")
                    completion(data, nil)
                }
                catch(let error) {
                    print("파싱 실패")
                    completion(nil, error)
                }
            case .failure(let error):
                print("통신 실패")
                completion(nil, error)
            }
            
        }
    }
    
    func requestDeleteStore(storeId: Int, completion: @escaping (ResponseData?, Error?) -> Void) {
        provider.request(.deleteStore(storeId: storeId)) { response in
            switch response {
            case .success(let deleteData):
                if deleteData.statusCode == 204 {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(ResponseData.self, from: deleteData.data)
                        completion(data, nil)
                    }
                    catch(let error) {
                        completion(nil, error)
                    }
                }
                else {
                    completion(nil, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func requestAddStore(name: String, zipcode: String, street: String, city: String, telNumber: String, tableList: [[String:Any]], completion: @escaping (LoginData?, Error?) -> Void) {
        provider.request(.addStore(name: name, zipcode: zipcode, street: street, city: city, telNumber: telNumber, tableList: tableList)) { response in
            switch response {
            case .success(let addStoreData):
                print(addStoreData.statusCode)
                if addStoreData.statusCode == 201 {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(LoginData.self, from: addStoreData.data)
                        completion(data, nil)
                    }
                    catch(let error) {
                        print("파싱 실패")
                        completion(nil, error)
                    }
                }
                else {
                    completion(nil, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
