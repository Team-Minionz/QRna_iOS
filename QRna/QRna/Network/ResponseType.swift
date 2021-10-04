//
//  ResponseType.swift
//  QRna
//
//  Created by 이명직 on 2021/10/04.
//

import Foundation

struct ResponseType<T: Codable>: Codable {
    var message: String?
    var data: [T]?
}

struct ResponseArrayType<T: Codable>: Codable {
        var message: String?
        var data: [T]?
}

struct LoginData: Codable {
    var email: String?
    var statusCode: Int?
}
