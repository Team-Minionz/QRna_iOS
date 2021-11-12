//
//  ConfusionViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/10/14.
//

import UIKit

class ConfusionViewController: UIViewController {

    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    let storeViewModel = StoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTable.delegate = self
        mainTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getStoreData()
    }
    
    fileprivate func getStoreData() {
        
        storeViewModel.getStoreList { result in
            switch result {
            case .success:
                self.mainTable.reloadData()
            case .failure:
                print("실패")
            }
        }
    }
    
    fileprivate func setStringValue(enumValue: String) -> String {
        var stringValue = ""
        
        switch enumValue {
        case "SMOOTH":
            stringValue = "원활"
        case "NORMAL":
            stringValue = "보통"
        default:
            stringValue = "혼잡"
        }
        
        return stringValue
    }
}

extension ConfusionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.storeViewModel.storeArray.count == 0{
            self.noDataLabel.isHidden = false
            self.mainTable.isHidden = true
        }
        else {
            self.noDataLabel.isHidden = true
            self.mainTable.isHidden = false
        }
        
        return storeViewModel.storeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTable.dequeueReusableCell(withIdentifier: "ConfusionCell", for: indexPath) as! ConfusionCell
        cell.name.text = storeViewModel.storeArray[indexPath.row].name
        cell.confuse.text = setStringValue(enumValue: storeViewModel.storeArray[indexPath.row].congestionStatus!)
        cell.address.text = "\(storeViewModel.storeArray[indexPath.row].address)"
        cell.tableStatus.text = "\(storeViewModel.storeArray[indexPath.row].useTables)/ \(storeViewModel.storeArray[indexPath.row].numberOfTables)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "UserPage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detailViewController") as! detailViewController
        vc.shopId = storeViewModel.storeArray[indexPath.row].id ?? -1
        present(vc, animated: true)
    }
}

class ConfusionCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var tableStatus: UILabel!
    @IBOutlet weak var confuse: UILabel!
}
