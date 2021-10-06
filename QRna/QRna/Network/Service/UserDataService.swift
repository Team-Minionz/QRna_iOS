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
    
    func requestSignIn(email: String, password: String, completion: @escaping ((ResponseData?, Error?)->Void)) {
        provider.request(.signin(email: email, password: password)) { response in
            
            print("DataService - \(response)")
            
            switch response {
            case .success(let loginData):
                print("DataService - 성공")
                if loginData.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        print("requestSignIn - data")
                        let post = try decoder.decode(ResponseData.self, from: loginData.data)
                        completion(post, nil)
                    }
                    catch (let error) {
                        print("DataService - 파싱 실패")
                        completion(nil, error)
                    }
                }
                else {
                    completion(nil, nil)
                }
                
            case .failure(let error):
                print("DataService - 실패")
                completion(nil, error)
                
            }
        }
    }
    
    func requestSignUp(name: String, email: String, nickName: String, telNumber: String, password: String, completion: @escaping ((ResponseData?, Error?)->Void)) {
        provider.request(.signup(name: name, email: email, nickName: nickName, telNumber: telNumber, password: password)) { response in
            
            print("DataService - sigUp : \(response)")
            switch response {
            case .success(let joinData):
                print("DataService - 성공")
                if joinData.statusCode == 201 {
                    do {
                        let decoder = JSONDecoder()
                        print("requestSignUp - data")
                        let data = try decoder.decode(ResponseData.self, from: joinData.data)
                        completion(data, nil)
                    }
                    catch (let error) {
                        print("DataService - 파싱 실패")
                        completion(nil, error)
                    }
                }
                else {
                    completion(nil, nil)
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
                if withdrawData.statusCode == 204 {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(ResponseData.self, from: withdrawData.data)
                        completion(data, nil)
                    }
                    catch(let error) {
                        print("DataService - requestWithdraw : 파싱 실패")
                        completion(nil, error)
                    }
                }
                else {
                    completion(nil, nil)
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
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(ResponseData.self, from: logoutData.data)
                    print("DataService - requestLogOut : 파싱 성공")
                    completion(data, nil)
                    
                }
                catch(let error) {
                    print("DataService - requestLogOut : 파싱 실패")
                    completion(nil, error)
                }
            case .failure(let error):
                print("DataService - requestLogOut : 통신 실패")
                completion(nil, error)
            }
            
        }
    }
}
