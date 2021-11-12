//
//  BookMarkViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/11/12.
//

import UIKit

class BookMarkViewController: UIViewController {

    @IBOutlet weak var bookMarkTable: UITableView!
    
    @IBOutlet weak var noDataLabel: UILabel!
    
    let userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookMarkTable.delegate = self
        bookMarkTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getBookMarkStores()
    }
    
    fileprivate func getBookMarkStores() {
        userViewModel.getBookMarkStores { response in
            switch response {
            case .success:
                self.bookMarkTable.reloadData()
            case .failure:
                self.bookMarkTable.isHidden = true
                self.noDataLabel.isHidden = false
            }
        }
    }
}

extension BookMarkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.userViewModel.bookMarkStores == nil || self.userViewModel.bookMarkStores?.count == 0{
            self.noDataLabel.isHidden = false
            self.bookMarkTable.isHidden = true
        }
        else {
            self.noDataLabel.isHidden = true
            self.bookMarkTable.isHidden = false
        }
        
        return userViewModel.storeList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookMarkTable.dequeueReusableCell(withIdentifier: "BookMarkCell", for: indexPath) as! BookMarkCell
        
        cell.name.text = userViewModel.storeList![indexPath.row].name
        cell.address.text = userViewModel.storeList![indexPath.row].address!.street! + " " +  userViewModel.storeList![indexPath.row].address!.city!
        cell.tableStatus.text = "\(userViewModel.storeList![indexPath.row].useTables) / \(userViewModel.storeList![indexPath.row].numberOfTables)"
        cell.degreeOfCongestion.text = userViewModel.storeList![indexPath.row].congestionStatus!
        
        return cell
    }
}

class BookMarkCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var tableStatus: UILabel!
    @IBOutlet weak var degreeOfCongestion: UILabel!
}
