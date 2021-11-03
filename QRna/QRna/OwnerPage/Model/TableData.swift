//
//  TableData.swift
//  QRna
//
//  Created by 이명직 on 2021/11/01.
//

import Foundation

struct TableData: Codable {
    let tableId: Int?
    let tableNumber: Int?
    let maxUser: Int?
    let countUser: Int?
    let useStatus: String?
}
