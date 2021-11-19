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
    var ownerTableDataInStore: [TableData]?
    var storeDetailData: StoreDetail?
    
    func getStoreList(latitude: Double, longitude: Double, sort: String, completion: @escaping (ViewModelState)->Void) {
        service.requestGetSotreList(latitude: latitude, longitude: longitude, sort: sort) { (storeData, error) in
            if storeData != nil {
                guard let storeList = storeData else{
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
    
    func addStore(name: String, zipcode: String, street: String, city: String, telNumber: String, tableList: [[String:Any]], completion: @escaping (ViewModelState) -> Void) {
        service.requestAddStore(name: name, zipcode: zipcode, street: street, city: city, telNumber: telNumber, tableList: tableList) { (addStoreData, error) in
            if addStoreData != nil {
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
    
    func getDetailTableInfo(storeId: Int, completion: @escaping (ViewModelState) -> Void) {
        service.requestGetTableDetailInfo(storeId: storeId) { (tableData, error) in
            if tableData != nil {
                self.ownerTableDataInStore = tableData
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
    
    func exitTable(tableId: Int, completion: @escaping (ViewModelState) -> Void) {
        service.requestExitTable(tableId: tableId) { (exitData, error) in
            if exitData != nil {
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
    
    func getStoreDetail(storeId: Int, completion: @escaping (ViewModelState) -> Void) {
        service.requestGetStoreDetail(storeId: storeId) { (detailData, error) in
            if detailData != nil {
                self.storeDetailData = detailData
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
        
    }
}
