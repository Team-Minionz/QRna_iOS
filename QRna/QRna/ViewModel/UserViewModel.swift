//
//  UserViewModel.swift
//  QRna
//
//  Created by 이명직 on 2021/10/04.
//

import Foundation

class UserViewModel {
    
    fileprivate let service = UserDataService()
    
    static var id = 1
    static var role = "USER"
    var infoData : Info?
    var ownerStoreData: [Store]?
    
    func signIn(email: String, password: String, role: String, completion: @escaping (ViewModelState) -> Void ) {
        service.requestSignIn(email: email, password: password, role: role) { (loginData, error) in
            
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
    
    func signUp(name: String, email: String, nickName: String, telNumber: String, password: String, role: String, zipcode: String, street: String, city: String, completion: @escaping (ViewModelState) -> Void) {
        service.requestSignUp(name: name, email: email, nickName: nickName, telNumber: telNumber, password: password, role: role, zipcode: zipcode, street: street, city: city) { (signUpdata, error) in
            
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
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
        
    }
    
    func findStoreByOwnerId(completion: @escaping (ViewModelState) -> Void) {
        service.requestFindStoreByOwnerId { (storeData, error) in
            if storeData != nil {
                print("getStore 성공")
                self.ownerStoreData = storeData
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
}
