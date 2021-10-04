//
//  UserServiceData.swift
//  QRna
//
//  Created by 이명직 on 2021/10/04.
//

import Foundation
import Moya

class UserDataService {
    fileprivate let provider = Moya.MoyaProvider<UserService>(endpointClosure: { (target: UserService) -> Endpoint in
        
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        switch target {
        default:
            let httpHeaderFields = ["Content-Type" : "application/json"]
            return defaultEndpoint.adding(newHTTPHeaderFields: httpHeaderFields)
        }
    })
    
    func requestSignIn(email: String, password: String, completion: @escaping ((LoginData?, Error?)->Void)) {
            provider.request(.signin(email: email, password: password)) { response in
                
                print("DataService - \(response)")
                switch response {
                case .success(let loginData):
                    print("DataService - 성공")
                    do {
                        let decoder = JSONDecoder()
                        print("requestSignIn - data")
                        let post = try decoder.decode(LoginData.self, from: loginData.data)
                        completion(post, nil)
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
    
}
