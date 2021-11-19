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
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var historyTable: UITableView!
    
    let userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTable.delegate = self
        historyTable.dataSource = self
        
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
                    self.userAddressLabel.text = data.address!.street! + " " + data.address!.city!
                    self.userPhoneNumberLabel.text = data.telNumber
                    
                    self.historyTable.reloadData()
                }
            case .failure:
                print("유저 데이터 가져오기 실패")
            }
        }
    }
}

extension MyInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userViewModel.history?.count == 0 || userViewModel.history == nil {
            noDataLabel.isHidden = false
            historyTable.isHidden = true
        }
        else {
            noDataLabel.isHidden = true
            historyTable.isHidden = false
        }
        return userViewModel.history?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTable.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        
        cell.name.text = userViewModel.history![indexPath.row].shopName!
        cell.number.text = userViewModel.history![indexPath.row].shopTelNumber
        cell.date.text = userViewModel.history![indexPath.row].visitedDate!
        
        let address = userViewModel.history![indexPath.row].shopAddress!.street! + " " +  userViewModel.history![indexPath.row].shopAddress!.city!
        
        cell.address.text = address
        
        return cell
    }
}

class HistoryCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var number: UILabel!
    
}
