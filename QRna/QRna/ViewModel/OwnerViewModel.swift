//
//  OwnerViewModel.swift
//  QRna
//
//  Created by 이명직 on 2021/10/19.
//

import Foundation

class OwnerViewModel {
    
    fileprivate let service = OwnerDataService()
    func addStore(name: String, zipcode: String, street: String, city: String, telNumber: String, completion: @escaping (ViewModelState)->Void) {
        service.requestAddStore(name: name, zipcode: zipcode, street: street, city: city, telNumber: telNumber) { (data, error) in
            if data != nil {
                completion(.success)
            }
            else {
                completion(.failure)
            }
        }
    }
}
