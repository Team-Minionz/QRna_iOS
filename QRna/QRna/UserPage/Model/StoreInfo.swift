//
//  StoreInfo.swift
//  QRna
//
//  Created by 이명직 on 2021/10/22.
//

import Foundation

struct StoreInfo: Codable {
    let id: Int?
    let name: String?
    let address: addressOfInfo?
    let congestionStatus: String?
    let numberOfTables: Int?
    let useTables: Int?
    let latitude: Double?
    let longitude: Double?
}

struct addressOfInfo: Codable {
    let city: String?
    let street: String?
}
