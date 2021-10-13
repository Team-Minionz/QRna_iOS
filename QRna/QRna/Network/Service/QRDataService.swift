//
//  QRDataService.swift
//  QRna
//
//  Created by 이명직 on 2021/10/06.
//

import Foundation
import Moya

class QRDataService {
    let provider = MoyaProvider<QRService>()
    
    func requestQRCertification(userEmail: String, shopTelNumber: String, completion: @escaping (ResponseData?, Error?) -> Void) {
        provider.request(.certification(userEmail: userEmail, shopTelNumber: shopTelNumber)) { response in
            print("QRDataService - requestQRCertification")
            switch response {
            case .success(let certificationData):
                print("QRDataService - requestQRCertification 성공")
                print(certificationData.data)
                print(certificationData.statusCode)
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(ResponseData.self, from: certificationData.data)
                    if certificationData.statusCode == 201 {
                        completion(data, nil)
                    }
                    else {
                        completion(nil, nil)
                    }
                }
                catch(let error) {
                    completion(nil, error)
                }
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
