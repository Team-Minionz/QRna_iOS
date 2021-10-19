//
//  ActionController.swift
//  QRna
//
//  Created by 이명직 on 2021/10/19.
//

import Foundation
import UIKit

class AlertController {
    func createAlertController(title: String, message: String) -> UIAlertController {
        let actionController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        return actionController
    }
}
