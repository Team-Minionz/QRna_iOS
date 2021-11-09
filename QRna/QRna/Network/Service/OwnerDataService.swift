//
//  OwnerDataService.swift
//  QRna
//
//  Created by 이명직 on 2021/11/08.
//

import Foundation
import Moya

class OwnerDataService {
    fileprivate let provider = Moya.MoyaProvider<OwnerService>()
    
    func requestSignIn(email: String, password: String, completion: @escaping ((LoginData?, Error?)->Void)) {
        provider.request(.signin(email: email, password: password)) { response in
            
            print("DataService - requestSignIn")
            
            switch response {
            case .success(let loginData):
                print("DataService - requestSignIn : 성공")
                print(loginData.data)
                print(loginData.statusCode)
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(LoginData.self, from: loginData.data)
                    print(data)
                    if loginData.statusCode == 200 {
                        OwnerViewModel.id = data.id!
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
                print("DataService - 실패")
                completion(nil, error)
                
            }
        }
    }
    
    func requestSignUp(name: String, email: String, nickName: String, telNumber: String, password: String, completion: @escaping ((ResponseData?, Error?)->Void)) {
        provider.request(.signup(name: name, email: email, nickName: nickName, telNumber: telNumber, password: password)) { response in
            
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
    
    func requestGetInfo(completion: @escaping (OwnerInfo?, Error?) -> Void) {
        provider.request(.getInfo) { response in
            switch response {
            case .success(let infoData):
                if infoData.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(OwnerInfo.self, from: infoData.data)
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
    
    func requestFindStoreByOwnerId(completion: @escaping ([Store]?, Error?) -> Void) {
        provider.request(.findStoreByOwnerId) { response in
            switch response {
            case .success(let storeData):
                print("requestFindStoreByOwnerId - 통신 성공")
                print(storeData)
                if storeData.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode([Store].self, from: storeData.data)
                        print(data)
                        completion(data, nil)
                    }
                    catch(let error) {
                        print("requestFindStoreByOwnerId - 파싱 실패")
                        completion(nil, error)
                    }
                }
                else {
                    print("requestFindStoreByOwnerId - 요청 실패")
                    completion(nil, nil)
                }
            case .failure(let error):
                print("requestFindStoreByOwnerId - 통신 실패")
                completion(nil, error)
            }
            
        }
    }
}
