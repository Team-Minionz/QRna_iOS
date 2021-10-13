//
//  CustomButton.swift
//  QRna
//
//  Created by 이명직 on 2021/10/07.
//

import Foundation
import UIKit

class CustomButton : UIButton{
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        let colorLiteral = #colorLiteral(red: 0.4315146208, green: 0.5936716199, blue: 0.9271910191, alpha: 1)
        self.layer.cornerRadius = 8
        self.layer.backgroundColor = colorLiteral.cgColor
        self.setTitleColor(.white, for: .normal)
        
    }
}
