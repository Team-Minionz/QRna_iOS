//
//  Store.swift
//  QRna
//
//  Created by 이명직 on 2021/10/21.
//

import Foundation

struct StoreDetail: Codable {
    let name: String?
    let number: String?
    let address: addressData?
    let telNumber: String?
    let tableInfoList: [TableListData]?
    let congestionStatus: String?
    let useUser: Int?
    let maxUser: Int?
    let bookMark: Bool?
}

struct TableListData: Codable {
    let maxUser: Int?
    let numberOfTable: Int?
}
