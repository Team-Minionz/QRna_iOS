//
//  ResponseType.swift
//  QRna
//
//  Created by 이명직 on 2021/10/04.
//

import Foundation

struct ResponseType<T: Codable>: Codable {
    var message: String?
    var data: T?
}

struct ResponseArrayType<T: Codable>: Codable {
        var message: String?
        var data: [T]?
}

struct ResponseData: Codable {
    var message: String?
}

struct LoginData: Codable {
    var id: Int?
    var message: String?
}
