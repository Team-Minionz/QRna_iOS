//
//  OwnerViewModel.swift
//  QRna
//
//  Created by 이명직 on 2021/11/08.
//

import Foundation

class OwnerViewModel {
    let service = OwnerDataService()
    static var id = -1
    var infoData : OwnerInfo?
    var ownerStoreData: [Store]?
    
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
    
    func signUp(name: String, email: String, nickName: String, telNumber: String, password: String, completion: @escaping (ViewModelState) -> Void) {
        service.requestSignUp(name: name, email: email, nickName: nickName, telNumber: telNumber, password: password) { (signUpdata, error) in
            
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
                self.ownerStoreData = storeData
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
}
