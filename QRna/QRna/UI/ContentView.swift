//
//  ContentView.swift
//  QRna
//
//  Created by 이명직 on 2021/10/14.
//

import Foundation
import UIKit
class ContentView: UIView {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = 10
        
        self.layer.shadowColor = UIColor.black.cgColor 
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.2
        
    }
}
