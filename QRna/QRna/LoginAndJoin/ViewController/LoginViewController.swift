//
//  LoginViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/10/13.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    let userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setSignUpBtn()
        
    }
    @IBAction func didTabSignIn(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "UserPage", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "UserPage")
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
        
//        var textFeilds = [UITextField]()
//        textFeilds.append(emailField)
//        textFeilds.append(passField)
//
//        if checkEmpty(textFeilds) {
//            userViewModel.signIn(email: self.emailField.text!, password: self.passField.text!) { response in
//                switch response {
//                case .success:
//                    print("성공")
//                case .failure:
//                    print("실패")
//                }
//
//            }
//        }
//        else {
//            // 공백 에러
//        }
    }
    
    fileprivate func checkEmpty(_ textFeilds: [UITextField]) -> Bool{
        for textFeild in textFeilds {
            if textFeild.text == "" {
                return false
            }
        }
        return true
    }
    
    fileprivate func setSignUpBtn() {
        let text = "아직 회원이 아니세요?"
        let attributedString = NSMutableAttributedString(string: text)
        let textColor = #colorLiteral(red: 0.04115622491, green: 0.07253655046, blue: 0.1939196885, alpha: 1)
        let underLine = NSUnderlineStyle.single.rawValue

        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSMutableAttributedString.Key.underlineStyle, value: underLine, range: NSRange(location: 0, length: text.count))

        self.signUpBtn.setAttributedTitle(attributedString, for: .normal)
    }
}
