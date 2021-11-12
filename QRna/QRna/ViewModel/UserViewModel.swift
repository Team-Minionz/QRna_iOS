//
//  UserViewModel.swift
//  QRna
//
//  Created by 이명직 on 2021/10/04.
//

import Foundation

class UserViewModel {
    
    fileprivate let service = UserDataService()
    
    static var id = -1
    var infoData : UserInfo?
    var history: [History]?
    var ownerStoreData: [Store]?
    var storeList: [StoreInfo]?
    var bookMarkStores: [StoreInfo]?
    
    func signIn(email: String, password: String, completion: @escaping (ViewModelState) -> Void ) {
        service.requestSignIn(email: email, password: password) { (loginData, error) in
            
            if loginData != nil {
                print("로그인 성공")
                completion(.success)
            }
            else {
                print("로그인 실패")
                completion(.failure)
            }
        }
    }
    
    func signUp(name: String, email: String, nickName: String, telNumber: String, password: String, zipcode: String, street: String, city: String, latitude: Double, longitude: Double, completion: @escaping (ViewModelState) -> Void) {
        service.requestSignUp(name: name, email: email, nickName: nickName, telNumber: telNumber, password: password, zipcode: zipcode, street: street, city: city, latitude: latitude, longitude: longitude) { (signUpdata, error) in
            
            if signUpdata != nil {
                print("가입 성공")
                completion(.success)
            }
            else {
                print("가입 실패")
                completion(.failure)
            }
        }
    }
    
    func withdraw(completion: @escaping (ViewModelState) -> Void) {
        service.requestWithdraw { (withdrawData, error) in
            
            if withdrawData != nil {
                print("탈퇴 성공")
                completion(.success)
            }
            else {
                print("탈퇴 실패")
                completion(.failure)
            }
        }
    }
    
    func logout(completion: @escaping (ViewModelState) -> Void) {
        service.requestLogOut { (logoutData, error) in
            
            if logoutData != nil {
                print("로그아웃 성공")
                completion(.success)
            }
            else {
                print("로그아웃 실패")
                completion(.failure)
            }
        }
    }
    
    func getInfo(completion: @escaping (ViewModelState) -> Void) {
        service.requestGetInfo { (infoData, error) in
            if infoData != nil {
                print("getInfo 성공")
                self.infoData = infoData
                self.history = infoData?.userVisitResponseList
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
    
    func bookMark(shopId: Int, completion: @escaping (ViewModelState) -> Void) {
        service.requestBookMark(shopId: shopId) { (bookMarkData, error) in
            if bookMarkData != nil {
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
    
    func removeBookMark(shopId: Int, completion: @escaping (ViewModelState) -> Void) {
        service.requestRemoveBookMark(shopId: shopId) { (removeData, error) in
            if removeData != nil {
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
    
    func searchStore(keyword: String, completion: @escaping (ViewModelState) -> Void) {
        service.requestSearchStore(keyword: keyword) { (searchData, error) in
            if searchData != nil {
                self.storeList = [StoreInfo]()
                self.storeList = searchData
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
    
    func searchStoreWithRegion(keyword: String, region: String, completion: @escaping (ViewModelState) -> Void) {
        service.requestSearchStoreWithRegion(keyword: keyword, region: region) { (searchData, error) in
            if searchData != nil {
                self.storeList = [StoreInfo]()
                self.storeList = searchData
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
    
    func getBookMarkStores(completion: @escaping (ViewModelState)->Void) {
        service.requestGetBookMarkStores { (storeData, error) in
            if storeData != nil {
                self.bookMarkStores = [StoreInfo]()
                self.bookMarkStores = storeData
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
}
