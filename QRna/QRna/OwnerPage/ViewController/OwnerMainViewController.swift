//
//  OwnerMainViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/10/14.
//

import UIKit

class OwnerMainViewController: UIViewController{

    @IBOutlet weak var mainTable: UITableView!
    
    let storeViewModel = StoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTable.delegate = self
        mainTable.dataSource = self
    }
    
    @IBAction func didTapAddBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "OwnerPage", bundle: nil)
        let popUp = storyboard.instantiateViewController(withIdentifier: "AddStoreViewController") as! AddStoreViewController
        
        present(popUp, animated: true)
    }
    
}

extension OwnerMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTable.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath) as! storeCell
        cell.delete = { [unowned self] in
            self.storeViewModel.deleteStore(storeId: 1) { result in
                switch result {
                case .success:
                    self.storeViewModel.ownerStoreArray.remove(at: indexPath.row)
                    self.mainTable.reloadData()
                case .failure:
                    print("")
                }
                
            }
        }
//        cell.nameLabel.text = stores[indexPath.row].name
//        cell.numberLabel.text = stores[indexPath.row].number
//        cell.addressLabel.text = stores[indexPath.row].address
        return cell
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
