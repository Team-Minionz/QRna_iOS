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
    
    @IBOutlet weak var storeName: UITextField!
    @IBOutlet weak var storeNumber: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var detailCity: UITextField!
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    
    var tableArray = [TableInfo]()
    let storeViewModel = StoreViewModel()
    
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
        var textFields = [UITextField]()
        textFields.append(storeName)
        textFields.append(storeNumber)
        textFields.append(city)
        textFields.append(detailCity)
        textFields.append(street)
        textFields.append(zipCode)
        
        if checkEmpty(textFields) {
            if tableArray.count == 0 {
                showErrorMessage(title: "등록 실패", message: "테이블 정보를 입력해 주세요")
            }
            else {
                // 테이블 정보 파싱 준비
                var tableList = [[String:Any]]()
                
                for item in tableArray {
                    tableList.append(["" : item.peopleCount, "": item.tableCount])
                }
                storeViewModel.addStore(name: self.zipCode.text!, zipcode: self.zipCode.text!, street: self.street.text!, city: self.city.text!, telNumber: self.storeNumber.text!) { result in
                    switch result {
                    case .success:
                        print("성공")
                    case .failure:
                        print("실패")
                    }
                    
                }
                self.dismiss(animated: true)
            }
        }
        else {
            showErrorMessage(title: "등록 실패", message: "모든 항목을 기입해 주세요")
        }
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
    
    fileprivate func showErrorMessage(title: String, message: String) {
        let alertController = AlertController().createAlertController(title: title, message: message)
        
        let yes = UIAlertAction(title: "확인", style: .cancel)
        alertController.addAction(yes)
        present(alertController, animated: true)
    }
    
    fileprivate func showSuccessMessage(title: String, message: String) {
        let alertController = AlertController().createAlertController(title: title, message: message)
        
        let yes = UIAlertAction(title: "확인", style: .cancel, handler: { (action) in
            self.navigationController?.popToRootViewController(animated: true)
            
        })
        alertController.addAction(yes)
        present(alertController, animated: true)
    }
    
    fileprivate func checkEmpty(_ textFeilds: [UITextField]) -> Bool{
        for textFeild in textFeilds {
            if textFeild.text == "" {
                return false
            }
        }
        return true
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
