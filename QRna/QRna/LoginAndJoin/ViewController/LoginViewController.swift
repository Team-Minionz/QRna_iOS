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
    let ownerViewModel = OwnerViewModel()
    var userType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setSignUpBtn()
        
    }
    @IBAction func didTapOwnerSignInBtn(_ sender: Any) {
        userType = "Owner"
        ownerSignIn()
    }
    @IBAction func didTapUserSignInBtn(_ sender: Any) {
        userType = "User"
        userSignIn()
    }
    
    fileprivate func userSignIn() {
        var textFeilds = [UITextField]()
        textFeilds.append(emailField)
        textFeilds.append(passField)

        if checkEmpty(textFeilds) {
            userViewModel.signIn(email: self.emailField.text!, password: self.passField.text!) { response in
                switch response {
                case .success:
                    print("성공")
                    self.moveNextVC(identifier: self.userType!)
                case .failure:
                    print("실패")
                    self.showErrorMessage(title: "로그인 실패", message: "서버가 원활하지 않습니다")
                }
            }
        }

        else {
            showErrorMessage(title: "로그인 실패", message: "아이디와 비밀번호를 입력해 주세요")
        }
    }
    
    fileprivate func ownerSignIn() {
        var textFeilds = [UITextField]()
        textFeilds.append(emailField)
        textFeilds.append(passField)

        if checkEmpty(textFeilds) {
            ownerViewModel.signIn(email: self.emailField.text!, password: self.passField.text!) { response in
                switch response {
                case .success:
                    print("성공")
                    self.moveNextVC(identifier: self.userType!)
                case .failure:
                    print("실패")
                    self.showErrorMessage(title: "로그인 실패", message: "서버가 원활하지 않습니다")
                }
            }
        }

        else {
            showErrorMessage(title: "로그인 실패", message: "아이디와 비밀번호를 입력해 주세요")
        }
    }
    
    fileprivate func moveNextVC(identifier: String) {
        let storyboard = UIStoryboard.init(name: identifier + "Page", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: identifier + "Page")
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    fileprivate func showErrorMessage(title: String, message: String) {
        let alertController = AlertController().createAlertController(title: title, message: message)
        
        let yes = UIAlertAction(title: "확인", style: .cancel)
        alertController.addAction(yes)
        present(alertController, animated: true)
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
