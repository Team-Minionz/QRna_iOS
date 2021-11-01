//
//  OwnerStroeDetailViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/11/01.
//

import UIKit

class OwnerStroeDetailViewController: UIViewController {

    @IBOutlet weak var detailListTable: UITableView!
    @IBOutlet weak var storeName: UILabel!
    
    let storeViewModel = StoreViewModel()
    var storeId = 0
    var storeNameStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTableDetailInfo()
        
        storeName.text = storeNameStr

        detailListTable.delegate = self
        detailListTable.dataSource = self
    }
    
    fileprivate func getTableDetailInfo() {
        storeViewModel.getDetailTableInfo(storeId: storeId) { response in
            switch response {
            case .success:
                print("성공")
                self.detailListTable.reloadData()
            case .failure:
                print("실패")
            }
            
        }
    }
    
}

extension OwnerStroeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storeViewModel.ownerTableDataInStore?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailListTable.dequeueReusableCell(withIdentifier: "DetailTableCell", for: indexPath) as! DetailTableCell
        
        cell.tableNumber.text = "\(storeViewModel.ownerTableDataInStore![indexPath.row].tableNumber)번"
        let tableUseStatus = storeViewModel.ownerTableDataInStore![indexPath.row].useStatus
        cell.tableUseStatus.text = tableUseStatus
        
        switch tableUseStatus {
        case "EMPTY":
            cell.exitBtn.isHidden = true
        default:
            cell.exitBtn.isHidden = false
        }
        
        cell.exit = { [unowned self] in
            self.storeViewModel.exitTable(tableId: self.storeViewModel.ownerTableDataInStore![indexPath.row].tableId!) { response in
                switch response {
                case .success:
                    print("성공")
                    self.detailListTable.reloadData()
                case .failure:
                    print("실패")
                }
                
            }
        }
        
        return cell
    }
}

class DetailTableCell: UITableViewCell {
    @IBOutlet weak var tableNumber: UILabel!
    @IBOutlet weak var tableUseStatus: UILabel!
    @IBOutlet weak var exitBtn: RedButton!
    
    var exit: (() -> ()) = {}
    
    @IBAction func didTapExitBtn(_ sender: Any) {
        exit()
    }
}
