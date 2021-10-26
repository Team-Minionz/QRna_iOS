//
//  MyInfoViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/10/14.
//

import UIKit

class MyInfoViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userPhoneNumberLabel: UILabel!
    @IBOutlet weak var userAddressLabel: UILabel!
    
    let userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInfoData()

    }
    
    @IBAction func didTabLogoutBtn(_ sender: Any) {
        userViewModel.logout { response in
            switch response {
            case .success:
                print("로그아웃 성공")
                self.dismiss(animated: true)
            case .failure:
                print("로그아웃 실패")
            }
            
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func didTabWithdrawBtn(_ sender: Any) {
        userViewModel.withdraw { response in
            switch response {
            case .success:
                print("탈퇴 성공")
                self.dismiss(animated: true)
            case .failure:
                print("탈퇴 실패")
            }
        }
    }
    
    fileprivate func getInfoData() {
        userViewModel.getInfo { response in
            switch response {
            case .success:
                DispatchQueue.main.async {
                    let data = self.userViewModel.infoData!
                    print(data)
                    self.userNameLabel.text = data.nickname! + "님"
                    self.userAddressLabel.text = data.address!.zipcode! + " " + data.address!.street! + " " + data.address!.city!
                    self.userPhoneNumberLabel.text = data.telNumber
                }
            case .failure:
                print("유저 데이터 가져오기 실패")
            }
            
        }
    }
}
