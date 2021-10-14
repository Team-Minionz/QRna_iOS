//
//  OwnerMainViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/10/14.
//

import UIKit

class OwnerMainViewController: UIViewController{

    @IBOutlet weak var mainTable: UITableView!
    
    var stores = [Store]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let store1 = Store(name: "코다차야", number: "010-2232-1234", address: "인천광역시 거기로 292-1")
        let store2 = Store(name: "일등포차", number: "010-1111-1111", address: "인천광역시 구월동 멋진대로 11-1")
        let store3 = Store(name: "재성이네", number: "010-112-112", address: "탈모광역시 없는대로 00-0")
        
        stores.append(store1)
        stores.append(store2)
        stores.append(store3)
        
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
        self.stores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTable.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath) as! storeCell
        cell.delete = { [unowned self] in
            self.stores.remove(at: indexPath.row)
            self.mainTable.reloadData()
        }
        cell.nameLabel.text = stores[indexPath.row].name
        cell.numberLabel.text = stores[indexPath.row].number
        cell.addressLabel.text = stores[indexPath.row].address
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
