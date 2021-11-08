//
//  Info.swift
//  QRna
//
//  Created by 이명직 on 2021/10/26.
//

import Foundation

struct UserInfo: Codable {
    let nickname: String?
    let telNumber: String?
    let address: addressData?
    let userVisitResponseList: [History]?
}

struct addressData: Codable {
    let street: String?
    let city: String?
}

