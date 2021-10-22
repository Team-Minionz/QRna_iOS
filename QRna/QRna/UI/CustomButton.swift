//
//  CustomButton.swift
//  QRna
//
//  Created by 이명직 on 2021/10/07.
//

import Foundation
import UIKit

class CustomButton : UIButton {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = 8
        self.setTitleColor(.white, for: .normal)
        
    }
}

class RedButton : UIButton {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        let colorLiteral = #colorLiteral(red: 0.8799410462, green: 0.2819583118, blue: 0.2278155088, alpha: 1)
        self.layer.cornerRadius = 4
        self.layer.backgroundColor = colorLiteral.cgColor
        self.setTitleColor(.white, for: .normal)
        
    }
}

class GrayButton : UIButton {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        let colorLiteral = #colorLiteral(red: 0.3607542515, green: 0.3608012795, blue: 0.3607382178, alpha: 1)
        self.layer.cornerRadius = 4
        self.layer.backgroundColor = colorLiteral.cgColor
        self.setTitleColor(.white, for: .normal)
        
    }
}

class MenuButton: UIButton {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = 8
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.2
    }
}
