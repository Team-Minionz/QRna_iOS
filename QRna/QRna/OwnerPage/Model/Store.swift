//
//  Store.swift
//  QRna
//
//  Created by 이명직 on 2021/10/14.
//

import Foundation

struct Store: Codable {
    let id: Int?
    let name: String?
    let address: Address?
    let numberOfTables: Int?
}

struct Address: Codable {
    let street: String?
    let city: String?
}
