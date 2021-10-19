//
//  ConfusionViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/10/14.
//

import UIKit

class ConfusionViewController: UIViewController {

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
}

extension ConfusionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTable.dequeueReusableCell(withIdentifier: "ConfusionCell", for: indexPath) as! ConfusionCell
        cell.name.text = stores[indexPath.row].name
        cell.address.text = stores[indexPath.row].address
        cell.confuse.text = "혼잡"
        
        return cell
    }
    
    
}

class ConfusionCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var confuse: UILabel!
    
}
