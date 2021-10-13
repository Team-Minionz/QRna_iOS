//
//  JoinViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/10/13.
//

import UIKit

class JoinViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var passCheckField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nickNameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    let userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapJoinBtn(_ sender: Any) {
        var textFeilds = [UITextField]()
        textFeilds.append(emailField)
        textFeilds.append(passField)
        textFeilds.append(passCheckField)
        textFeilds.append(nameField)
        textFeilds.append(nickNameField)
        textFeilds.append(phoneNumberField)
        
        if checkEmpty(textFeilds) {
            if self.checkPassword(self.passField.text!, self.passCheckField.text!) {
                userViewModel.signUp(name: self.nameField.text!, email: self.emailField.text!, nickName: self.nickNameField.text!, telNumber: self.phoneNumberField.text!, password: self.passField.text!) { response in
                    
                    switch response {
                    case .success:
                        print("가입 성공")
                    case .failure:
                        print("가입 실패")
                    }
                }
            }
            else {
                // 패스워드 일치 확인 메시지
                print("비밀번호 불일치")
            }
        }
        else {
            // 공백 메시지
            print("빈 칸 확인")
        }
        
        
    }
    
    @IBAction func didTabCancelBtn(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    fileprivate func checkEmpty(_ textFeilds: [UITextField]) -> Bool{
        for textFeild in textFeilds {
            if textFeild.text == "" {
                return false
            }
        }
        return true
    }
    
    fileprivate func checkPassword(_ passStr: String, _ checkPassStr: String) -> Bool {
        if passStr == checkPassStr {
            return true
        }
        return false
    }
}
