//
//  JoinViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/10/13.
//

import UIKit
import DropDown

class JoinViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var passCheckField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nickNameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var userTypeBtn: UIButton!
    
    @IBOutlet weak var zipcode: UITextField!
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var addressStack: UIStackView!
    
    let userViewModel = UserViewModel()
    let ownerViewModel = OwnerViewModel()
    let dropDown = DropDown()
    let latitude = 27.0
    let longitude = 103.0
    var userTypeStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDropDownBtn()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.userTypeBtn.setTitle(item, for: .normal)
            self.userTypeStr = item
            
            if index == 0 {
                addressStack.isHidden = false
            }
            else {
                addressStack.isHidden =  true
            }
        }
    }
    
    @IBAction func didTapJoinBtn(_ sender: Any) {
        var textFeilds = [UITextField]()
        textFeilds.append(emailField)
        textFeilds.append(passField)
        textFeilds.append(passCheckField)
        textFeilds.append(nameField)
        textFeilds.append(nickNameField)
        textFeilds.append(phoneNumberField)
        
        if userTypeStr == "유저" {
            textFeilds.append(zipcode)
            textFeilds.append(street)
            textFeilds.append(city)
        }
        
        var title = ""
        var message = ""
        
        if userTypeStr == "" {
            showErrorMessage(title: "가입 실패", message: "회원 유형을 선택해 주세요")
        }
        else {
            if checkEmpty(textFeilds) {
                if self.checkPassword(self.passField.text!, self.passCheckField.text!) {
                    var zipcodeStr = ""
                    var streetStr = ""
                    var cityStr = ""
                    if userTypeStr == "유저" {
                        zipcodeStr = self.zipcode.text!
                        streetStr = self.street.text!
                        cityStr = self.city.text!
                        
                        userViewModel.signUp(name: self.nameField.text!, email: self.emailField.text!, nickName: self.nickNameField.text!, telNumber: self.phoneNumberField.text!, password: self.passField.text!, zipcode: zipcodeStr, street: streetStr, city: cityStr, latitude: self.latitude, longitude: self.longitude) { response in
                            
                            switch response {
                            case .success:
                                print("가입 성공")
                                title = "가입 성공"
                                message = "가입을 축하합니다!"
                                self.showSuccessMessage(title: title, message: message)
                                
                            case .failure:
                                print("가입 실패")
                                title = "가입 실패"
                                message = "서버가 원활하지 않습니다"
                                self.showErrorMessage(title: title, message: message)
                            }
                        }
                    }
                    else {
                        ownerViewModel.signUp(name: self.nameField.text!, email: self.emailField.text!, nickName: self.nickNameField.text!, telNumber: self.phoneNumberField.text!, password: self.passField.text!) { response in
                            switch response {
                            case .success:
                                print("가입 성공")
                                title = "가입 성공"
                                message = "가입을 축하합니다!"
                                self.showSuccessMessage(title: title, message: message)
                                
                            case .failure:
                                print("가입 실패")
                                title = "가입 실패"
                                message = "서버가 원활하지 않습니다"
                                self.showErrorMessage(title: title, message: message)
                            }
                        }
                    }
                }
                else {
                    print("비밀번호 불일치")
                    title = "가입 실패"
                    message = "비밀번호를 확인해 주세요"
                    showErrorMessage(title: title, message: message)
                }
            }
            else {
                // 공백 메시지
                print("빈 칸 확인")
                title = "가입 실패"
                message = "모든 항목을 기입해 주세요"
                showErrorMessage(title: title, message: message)
            }
        }
    }
    
    @IBAction func didTabCancelBtn(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didTapUserTypeBtn(_ sender: Any) {
        self.dropDown.show()
    }
    
    fileprivate func checkEmpty(_ textFeilds: [UITextField]) -> Bool{
        for textFeild in textFeilds {
            if textFeild.text == "" {
                return false
            }
        }
        return true
    }
    
    fileprivate func setEnumValue(stringValue: String) -> String {
        var value = ""
        switch stringValue {
        case "점주":
            value = "OWNER"
        default:
            value = "USER"
        }
        return value
    }
    
    fileprivate func showErrorMessage(title: String, message: String) {
        let alertController = AlertController().createAlertController(title: title, message: message)
        
        let yes = UIAlertAction(title: "확인", style: .cancel)
        alertController.addAction(yes)
        present(alertController, animated: true)
    }
    
    fileprivate func showSuccessMessage(title: String, message: String) {
        let alertController = AlertController().createAlertController(title: title, message: message)
        
        let yes = UIAlertAction(title: "확인", style: .cancel, handler: { (action) in
            self.navigationController?.popToRootViewController(animated: true)
            
        })
        alertController.addAction(yes)
        present(alertController, animated: true)
    }
    
    fileprivate func checkPassword(_ passStr: String, _ checkPassStr: String) -> Bool {
        if passStr == checkPassStr {
            return true
        }
        return false
    }
    
    fileprivate func setDropDownBtn() {
        dropDown.dataSource = ["유저", "점주"]
        dropDown.anchorView = userTypeBtn
        dropDown.bottomOffset = CGPoint(x: 0, y: (dropDown.anchorView?.plainView.bounds.height)!)
        
        DropDown.appearance().cornerRadius = 8
    }
}
