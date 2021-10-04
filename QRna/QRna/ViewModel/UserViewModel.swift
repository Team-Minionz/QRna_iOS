//
//  UserViewModel.swift
//  QRna
//
//  Created by 이명직 on 2021/10/04.
//

import Foundation

class UserViewModel {
    
    fileprivate let service = UserDataService()
    
    func signIn(email: String, password: String, completion: @escaping (ViewModelState) -> Void ) {
        service.requestSignIn(email: email, password: password) { (loginData, error) in
            if loginData?.statusCode == 200 {
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
            if singUpdata?.statusCode == 201 {
                print("가입 성공")
                completion(.success)
            }
            else {
                print("가입 실패")
                completion(.failure)
            }
        }
        
    }
}
