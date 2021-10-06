//
//  QRDataService.swift
//  QRna
//
//  Created by 이명직 on 2021/10/05.
//

import Foundation
import Moya

class QRDataService {
    let service = Moya.MoyaProvider<QRService>(endpointClosure: { (target: QRService) -> Endpoint in
        
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        switch target {
        default:
            let httpHeaderFields = ["Content-Type" : "application/json"]
            return defaultEndpoint.adding(newHTTPHeaderFields: httpHeaderFields)
        }
    })
    
    func requestQRCertification(userEmail: String, shopTelNumber: String, completion: @escaping (ResponseData?, Error?) -> Void) {
        service.request(.certification(userEmail: userEmail, shopTelNumber: shopTelNumber)) { response in
            print("QRDataService - requestQRCertification")
            switch response {
            case .success(let certificationData):
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(ResponseData.self, from: certificationData.data)
                    completion(data, nil)
                }
                catch(let error) {
                    print("파싱 실패")
                    completion(nil, error)
                }
            case .failure(let error):
                print("통신 실패")
                completion(nil, error)
            }
        }
    }
}
