//
//  QRViewModel.swift
//  QRna
//
//  Created by 이명직 on 2021/10/05.
//

import Foundation

class QRViewModel {
    fileprivate let service = QRDataService()
    
    func certificationQR(userEmail: String, shopTelNumber: String, completion: @escaping (ViewModelState) -> Void) {
        service.requestQRCertification(userEmail: userEmail, shopTelNumber: shopTelNumber) { (certificationData, error) in
            if certificationData?.statusCode == 204 {
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
}
