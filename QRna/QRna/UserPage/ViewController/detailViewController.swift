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
    @IBOutlet weak var useRatio: UILabel!
    @IBOutlet weak var bookMarkBtn: UIButton!
    @IBOutlet weak var contentView: ContentView!
    
    var temp = [StoreTemp]()
    var isLiked = false
    var shopId = -1
    let userViewModel = UserViewModel()
    let storeViewModel = StoreViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.contentView.bringSubviewToFront(self.bookMarkBtn)
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
        storeViewModel.getStoreDetail(storeId: 1) { response in
            switch response {
            case .success:
                print("성공")
            case .failure:
                print("실패")
            }
            
        }
        
    
        setBookMark()
        storeTable.delegate = self
        storeTable.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isLiked {
            userViewModel.bookMark(shopId: self.shopId) { response in
                switch response {
                case .success:
                    print("북마크 성공")
                case .failure:
                    print("북마크 실패")
                }
            }
        }
        else {
            userViewModel.removeBookMark(shopId: self.shopId) { response in
                switch response {
                case .success:
                    print("북마크 해제 성공")
                case .failure:
                    print("북마크 해제 실패")
                }
            }
        }
    }
    
    @IBAction func didTapConfirmBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func didTapBookMarkBtn(_ sender: Any) {
        isLiked = !isLiked
        setBookMark()
    }
    
    fileprivate func setBookMark() {
        if !isLiked {
            bookMarkBtn.setImage(UIImage(named: "like1"), for: .normal)
        }
        else {
            bookMarkBtn.setImage(UIImage(named: "like2"), for: .normal)
        }
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
