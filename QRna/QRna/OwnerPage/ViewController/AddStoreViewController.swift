//
//  AddStoreViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/10/14.
//

import UIKit

class AddStoreViewController: UIViewController {

    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var numberOfPeople: UITextField!
    @IBOutlet weak var numberOfTable: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    var tableArray = [TableInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTable.delegate = self
        mainTable.dataSource = self

    }
    
    @IBAction func didTapAddBtn(_ sender: Any) {
        if numberOfTable.text != "" && numberOfPeople.text != "" {
            let people = numberOfPeople.text!
            let table = numberOfTable.text!
            
            checkDuplicationAndSetArray(Int(people)!, Int(table)!)
            setTotalCount()
            mainTable.reloadData()
            
            numberOfPeople.text = nil
            numberOfTable.text = nil
        }
        self.view.endEditing(true)
    }
    
    @IBAction func didTabAddBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func didTabCancelBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    fileprivate func setTotalCount() {
        var totalOfTable = 0
        var totalOfPeople = 0
        if tableArray.count != 0 {
            for i in 0...tableArray.count-1 {
                totalOfTable += tableArray[i].tableCount
                totalOfPeople += tableArray[i].tableCount*tableArray[i].peopleCount
            }
        }
        
        totalLabel.text = "\(totalOfTable) 테이블 / \(totalOfPeople) 명"
    }
    
    fileprivate func checkDuplicationAndSetArray(_ numberOfPeople: Int, _ numberOfTable: Int){
//        if tableArray.count == 0 {
//            tableArray.append(TableInfo(tableCount: numberOfTable, peopleCount: numberOfPeople))
//            return
//        }
        var index = 0
        for item in tableArray {
            if item.peopleCount == numberOfPeople {
                tableArray[index].tableCount += numberOfTable
                return
            }
            index += 1
        }
        tableArray.append(TableInfo(tableCount: numberOfTable, peopleCount: numberOfPeople))
    }
}

extension AddStoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTable.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! tableCell
        
        cell.tableInfo.text = "\(tableArray[indexPath.row].peopleCount)인 테이블 x \(tableArray[indexPath.row].tableCount)개"
        cell.delete = { [unowned self] in
            self.tableArray.remove(at: indexPath.row)
            self.mainTable.reloadData()
            self.setTotalCount()
        }
        
        return cell
    }
}

class tableCell: UITableViewCell {
    
    @IBOutlet weak var tableInfo: UILabel!
    
    var delete: (() -> ()) = {}
    
    @IBAction func didTabDelete(_ sender: Any) {
        delete()
    }
}

struct TableInfo {
    var tableCount: Int
    var peopleCount: Int
}
