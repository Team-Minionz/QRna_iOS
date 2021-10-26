//
//  Info.swift
//  QRna
//
//  Created by 이명직 on 2021/10/26.
//

import Foundation

struct Info: Codable {
    var nickname: String?
    var telNumber: String?
    var address: addressData?
    
    struct addressData: Codable {
        var zipcode: String?
        var street: String?
        var city: String?
    }
}
