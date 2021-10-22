//
//  StoreViewModel.swift
//  QRna
//
//  Created by 이명직 on 2021/10/22.
//

import Foundation

class StoreViewModel {
    let service = StoreDataService()
    var storeArray = [StoreInfo]()
    var ownerStoreArray = [Store]()
    
    func getStoreList(completion: @escaping (ViewModelState)->Void) {
        service.requestGetSotreList() { (storeData, error) in
            if storeData != nil {
                guard let storeList = storeData?.data else{
                    completion(.success)
                    return
                }
                self.storeArray = storeList
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
    
    func deleteStore(storeId: Int, completion: @escaping (ViewModelState)->Void) {
        service.requestDeleteStore(storeId: storeId) { (deleteData, error) in
            if deleteData != nil {
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
    
    func addStore(name: String, zipcode: String, street: String, city: String, telNumber: String, completion: @escaping (ViewModelState) -> Void) {
        service.requestAddStore(name: name, zipcode: zipcode, street: street, city: city, telNumber: telNumber) { (addStoreData, error) in
            if addStoreData != nil {
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
}
