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
            switch response {
            case .success(let certificationData):
                if certificationData.statusCode == 201 {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(ResponseData.self, from: certificationData.data)
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
}
