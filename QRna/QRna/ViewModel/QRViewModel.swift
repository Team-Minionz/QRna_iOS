//
//  QRViewModel.swift
//  QRna
//
//  Created by 이명직 on 2021/10/05.
//

import Foundation

class QRViewModel {
    fileprivate let service = QRDataService()
    
    func certificationQR(userEmail: String, tableId: Int, completion: @escaping (ViewModelState) -> Void) {
        service.requestQRCertification(userEmail: userEmail, tableId: tableId) { (certificationData, error) in
            if certificationData != nil {
                print("QR 인증 성공")
                completion(.success)
            }
            else {
                print("QR 인증 실패")
                completion(.failure)
            }
        }
    }
}
