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
    
    func requestGetSotreList(latitude: Double, longitude: Double, completion: @escaping ([StoreInfo]?, Error?) -> Void) {
        provider.request(.getStoreList(latitude: latitude, longitude: longitude)) { response in
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
    
    func requestGetTableDetailInfo(storeId: Int, completion: @escaping ([TableData]?, Error?) -> Void) {
        provider.request(.getDetailTableInfo(storeId: storeId)) { response in
            switch response {
            case .success(let tableData):
                if tableData.statusCode == 200 {
                    print("requestGetTableDetailInfo - 요청 성공")
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode([TableData].self, from: tableData.data)
                        completion(data, nil)
                    }
                    catch(let error) {
                        print("파싱 실패")
                        completion(nil, error)
                    }
                }
            case .failure(let error):
                print("requestGetTableDetailInfo - 요청 실패")
                completion(nil, error)
            }
            
        }
    }
    
    func requestExitTable(tableId: Int, completion: @escaping (ResponseData?, Error?) -> Void) {
        provider.request(.exitTable(tableId: tableId)) { response in
            switch response {
            case .success(let exitData):
                if exitData.statusCode == 200 {
                    print("requestExitTable - 요청 성공")
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(ResponseData.self, from: exitData.data)
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
                print("requestExitTable - 요청 실패")
                completion(nil, error)
            }
        }
    }
    
    func requestGetStoreDetail(storeId: Int, completion: @escaping (StoreDetail?, Error?) -> Void) {
        provider.request(.getStoreDetail(storeId: storeId)) { response in
            switch response {
            case .success(let detailData):
                print(detailData)
                if detailData.statusCode == 200 {
                    do {
                        print("통신 성공")
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(StoreDetail.self, from: detailData.data)
                        print(data)
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
                print("통신 실패")
                completion(nil, error)
            }
            
        }
    }
}
