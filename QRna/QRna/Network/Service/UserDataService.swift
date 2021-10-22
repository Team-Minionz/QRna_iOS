//
//  UserServiceData.swift
//  QRna
//
//  Created by 이명직 on 2021/10/04.
//

import Foundation
import Moya

class UserDataService {
    
    fileprivate let provider = Moya.MoyaProvider<UserService>()
    
    func requestSignIn(email: String, password: String, role: String, completion: @escaping ((ResponseData?, Error?)->Void)) {
        provider.request(.signin(email: email, password: password, role: role)) { response in
            
            print("DataService - requestSignIn")
            
            switch response {
            case .success(let loginData):
                print("DataService - requestSignIn : 성공")
                print(loginData.data)
                print(loginData.statusCode)
                do {
                    let decoder = JSONDecoder()
                    let post = try decoder.decode(ResponseData.self, from: loginData.data)
                    print(post.message)
                    if loginData.statusCode == 200 {
                        completion(post, nil)
                    }
                    else {
                        completion(nil, nil)
                    }
                }
                catch (let error) {
                    print("DataService - 파싱 실패")
                    completion(nil, error)
                }
                
            case .failure(let error):
                print("DataService - 실패")
                completion(nil, error)
                
            }
        }
    }
    
    func requestSignUp(name: String, email: String, nickName: String, telNumber: String, password: String, role: String, completion: @escaping ((ResponseData?, Error?)->Void)) {
        provider.request(.signup(name: name, email: email, nickName: nickName, telNumber: telNumber, password: password, role: role)) { response in
            
            print("DataService - requestSignUp")
            switch response {
            case .success(let joinData):
                print("DataService - requestSignUp : 성공")
                print(joinData.data)
                print(joinData.statusCode)
                
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(ResponseData.self, from: joinData.data)
                    print(data.message)
                    if joinData.statusCode == 201 {
                        completion(data, nil)
                    }
                    else {
                        completion(nil, nil)
                    }
                    
                }
                catch (let error) {
                    print("DataService - 파싱 실패")
                    completion(nil, error)
                }
                
            case .failure(let error):
                print("DataService - 통신 실패")
                completion(nil, error)
                
            }
        }
    }
    
    func requestWithdraw(completion: @escaping (ResponseData?, Error?) -> Void) {
        provider.request(.withdraw) { response in
            print("DataService - requestWithdraw")
            switch response {
            case .success(let withdrawData):
                print("DataService - requestWithdraw : 성공")
                print(withdrawData.data)
                print(withdrawData.statusCode)
                if withdrawData.statusCode == 204 {
                    let data = ResponseData(message: "회원탈퇴 성공")
                    completion(data, nil)
                }
                else {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(ResponseData.self, from: withdrawData.data)
                        print(data.message)
                        completion(nil, nil)
                        
                    }
                    catch(let error) {
                        print("DataService - requestWithdraw : 파싱 실패")
                        completion(nil, error)
                    }
                }
                
            case .failure(let error):
                print("DataService - requestWithdraw : 통신 실패")
                completion(nil, error)
            }
        }
    }
    
    func requestLogOut(completion: @escaping (ResponseData?, Error?) -> Void) {
        provider.request(.logout) { response in
            
            print("DataService - requestLogOut")
            
            switch response {
            case .success(let logoutData):
                print("DataService - requestLogOut : 성공")
                print(logoutData.data)
                print(logoutData.statusCode)
            
                if logoutData.statusCode == 204 {
                    let data = ResponseData(message: "로그아웃 성공")
                    completion(data, nil)
                }
                else {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(ResponseData.self, from: logoutData.data)
                        print(data.message)
                        completion(nil, nil)
                        
                        
                    }
                    catch(let error) {
                        print("DataService - requestLogOut : 파싱 실패")
                        completion(nil, error)
                    }
                }
            case .failure(let error):
                print("DataService - requestLogOut : 통신 실패")
                completion(nil, error)
            }
            
        }
    }
}
