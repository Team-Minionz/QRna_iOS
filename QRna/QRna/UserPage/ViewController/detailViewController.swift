//
//  detailViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/10/21.
//

import UIKit

class detailViewController: UIViewController {
    
    @IBOutlet weak var tableContentView: UIView!
    @IBOutlet weak var storeTable: UITableView!
    var temp = [StoreTemp]()

    override func viewDidLoad() {
        super.viewDidLoad()

        temp.append(StoreTemp(tableMaxNumberOfPeople: 2, currentNumberOPeople: 4, totalNumberOfPeople: 10))
        temp.append(StoreTemp(tableMaxNumberOfPeople: 3, currentNumberOPeople: 5, totalNumberOfPeople: 30))
        temp.append(StoreTemp(tableMaxNumberOfPeople: 4, currentNumberOPeople: 8, totalNumberOfPeople: 40))
        temp.append(StoreTemp(tableMaxNumberOfPeople: 5, currentNumberOPeople: 8, totalNumberOfPeople: 40))
        temp.append(StoreTemp(tableMaxNumberOfPeople: 6, currentNumberOPeople: 8, totalNumberOfPeople: 40))
        temp.append(StoreTemp(tableMaxNumberOfPeople: 7, currentNumberOPeople: 8, totalNumberOfPeople: 40))
        temp.append(StoreTemp(tableMaxNumberOfPeople: 8, currentNumberOPeople: 8, totalNumberOfPeople: 40))
        
        tableContentView.layer.cornerRadius = 10
        tableContentView.layer.borderColor = #colorLiteral(red: 0.9048041701, green: 0.8994255662, blue: 0.9089386463, alpha: 1)
        tableContentView.layer.borderWidth = 0.8
        
        //storeTable.rowHeight = UITableView.automaticDimension
        storeTable.delegate = self
        storeTable.dataSource = self
    }
    
    @IBAction func didTapConfirmBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension detailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        temp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = storeTable.dequeueReusableCell(withIdentifier: "StoreDetailCell", for: indexPath) as! StoreDetailCell
        cell.numberOfPeople.text = "\(temp[indexPath.row].tableMaxNumberOfPeople)인 테이블"
        cell.fonfusion.text = "\(temp[indexPath.row].currentNumberOPeople) / \(temp[indexPath.row].totalNumberOfPeople)"
        return cell
    }
}

class IntrinsicTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        let number = numberOfRows(inSection: 0)
        var height: CGFloat = 0

        for i in 0..<number {
            guard let cell = cellForRow(at: IndexPath(row: i, section: 0)) else {
                continue
            }
            height += cell.bounds.height
        }
        return CGSize(width: contentSize.width, height: height)
    }
}

class StoreDetailCell: UITableViewCell {
    @IBOutlet weak var numberOfPeople: UILabel!
    @IBOutlet weak var fonfusion: UILabel!
}

struct StoreTemp {
    let tableMaxNumberOfPeople: Int
    let currentNumberOPeople: Int
    let totalNumberOfPeople: Int
}
