//
//  History.swift
//  QRna
//
//  Created by 이명직 on 2021/11/02.
//

import Foundation

struct History: Codable {
    let shopName: String?
    let shopAddress: Address?
    let shopTelNumber: String?
    let visitedDate: String?
    
    struct Address: Codable {
        let street: String?
        let city: String?
    }
}
