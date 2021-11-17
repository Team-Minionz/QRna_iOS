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
        
        self.layer.cornerRadius = 4
        
        self.layer.shadowColor = UIColor.black.cgColor 
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.2
        
    }
}

class MainView: UIView {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = 40
        
    }
}

class TableContainView: UIView {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 0.8
        self.layer.borderColor = #colorLiteral(red: 0.9048041701, green: 0.8994255662, blue: 0.9089386463, alpha: 1)
        
    }
}
