//
//  OwnerMainViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/10/14.
//

import UIKit
import SwiftyJSON

class OwnerMainViewController: UIViewController{

    @IBOutlet weak var mainTable: UITableView!
    
    let userViewModel = UserViewModel()
    let storeViewModel = StoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTable.delegate = self
        mainTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getStoreList()
    }
    
    fileprivate func getStoreList() {
        userViewModel.findStoreByOwnerId { response in
            switch response {
            case .success:
                print("성공")
            case .failure:
                print("실패")
            }
        }
    }
    
    @IBAction func didTapAddBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "OwnerPage", bundle: nil)
        let popUp = storyboard.instantiateViewController(withIdentifier: "AddStoreViewController") as! AddStoreViewController
        
        present(popUp, animated: true)
    }
    
}

extension OwnerMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModel.ownerStoreData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTable.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath) as! storeCell
        cell.delete = { [unowned self] in
            let storeId = userViewModel.ownerStoreData![indexPath.row].id!
            self.storeViewModel.deleteStore(storeId: storeId) { result in
                switch result {
                case .success:
                    self.storeViewModel.ownerStoreArray.remove(at: indexPath.row)
                    self.mainTable.reloadData()
                case .failure:
                    print("")
                }
            }
        }
        cell.nameLabel.text = userViewModel.ownerStoreData![indexPath.row].name
        let addressStr = userViewModel.ownerStoreData![indexPath.row].address!.street! + " " + userViewModel.ownerStoreData![indexPath.row].address!.city!
        cell.addressLabel.text = addressStr
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "OwnerPage", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "OwnerStroeDetailViewController") as! OwnerStroeDetailViewController
        
        vc.storeId = userViewModel.ownerStoreData![indexPath.row].id!
        vc.storeNameStr = userViewModel.ownerStoreData![indexPath.row].name!
        
        present(vc, animated: true)
    }
}

class storeCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var delete: (() -> ()) = {}
    
    @IBAction func didTabDelete(_ sender: Any) {
        delete()
    }
}
