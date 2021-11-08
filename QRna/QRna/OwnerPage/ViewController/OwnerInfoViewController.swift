//
//  OwnerInfoViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/11/08.
//

import UIKit

class OwnerInfoViewController: UIViewController {

    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerPhoneNumberLabel: UILabel!
    
    let ownerViewModel = OwnerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInfoData()
    }

    @IBAction func didTabWithdrawBtn(_ sender: Any) {
        ownerViewModel.withdraw { response in
            switch response {
            case .success:
                print("탈퇴 성공")
                self.dismiss(animated: true)
            case .failure:
                print("탈퇴 실패")
            }
        }
    }
    
    @IBAction func didTapLogoutBtn(_ sender: Any) {
        ownerViewModel.logout { response in
            switch response {
            case .success:
                print("로그아웃 성공")
                self.dismiss(animated: true)
            case .failure:
                print("로그아웃 실패")
            }
        }
    }
    
    
    fileprivate func getInfoData() {
        ownerViewModel.getInfo { response in
            switch response {
            case .success:
                DispatchQueue.main.async {
                    let data = self.ownerViewModel.infoData!
                    print(data)
                    self.ownerNameLabel.text = data.nickname! + "님"
                    self.ownerPhoneNumberLabel.text = data.telNumber
                    
                }
            case .failure:
                print("유저 데이터 가져오기 실패")
            }
        }
    }
}
