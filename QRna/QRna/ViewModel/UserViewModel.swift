//
//  UserViewModel.swift
//  QRna
//
//  Created by 이명직 on 2021/10/04.
//

import Foundation

class UserViewModel {
    
    fileprivate let service = UserDataService()
    
    static var userEmail = "b@b.b"
    
    func signIn(email: String, password: String, completion: @escaping (ViewModelState) -> Void ) {
        service.requestSignIn(email: email, password: password) { (loginData, error) in
            
            if error != nil {
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
        service.requestSignUp(name: name, email: email, nickName: nickName, telNumber: telNumber, password: password) { (singUpdata, error) in
            if error != nil {
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
            if error != nil {
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
            if error != nil {
                print("로그아웃 성공")
                completion(.success)
            }
            else {
                print("로그아웃 실패")
                completion(.failure)
            }
        }
    }
}
