//
//  SearchViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/11/07.
//

import UIKit

class SearchViewController: UIViewController{
    
    @IBOutlet weak var regionCollectionView: UICollectionView!
    @IBOutlet weak var keywordLabel: UITextField!
    @IBOutlet weak var searchBtn: RedButton!
    @IBOutlet weak var searchTableView: UITableView!
    
    var flowLayout = UICollectionViewFlowLayout()
    let regionArray = ["서울","인천","경기도","강원도","충청도", "전라도", "경상도", "제주도"]
    
    var regionValue = ""
    
    let userViewModel = UserViewModel()
    
    let w : CGFloat = UIScreen.main.bounds.width
    let h : CGFloat = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegionLayout()
       
    }
    
    @IBAction func didTapSearchBtn(_ sender: Any) {
        if keywordLabel.text == "" {
            showErrorMessage(title: "검색 실패", message: "키워드를 입력해 주세요")
        }
        else {
            setTableView()
            if regionValue == "" {
                userViewModel.searchStore(keyword: keywordLabel.text!) { response in
                    switch response {
                    case .success:
                        print("키워드 검색 성공")
                        if self.userViewModel.storeList?.count == 0 {
                            self.showErrorMessage(title: "", message: "검색된 데이터가 없습니다.")
                        }
                        self.searchTableView.reloadData()
                    case .failure:
                        print("키워드 검색 실패")
                        self.showErrorMessage(title: "검색 실패", message: "서버가 원활하지 않습니다")
                    }
                }
            }
            
            else {
              
                userViewModel.searchStoreWithRegion(keyword: keywordLabel.text!, region: regionValue) { response in
                    switch response {
                    case .success:
                        print("키워드/지역 검색 성공")
                        if self.userViewModel.storeList?.count == 0 {
                            self.showErrorMessage(title: "", message: "검색된 데이터가 없습니다.")
                        }
                        self.searchTableView.reloadData()
                    case .failure:
                        print("키워드/지역 검색 실패")
                        self.showErrorMessage(title: "검색 실패", message: "서버가 원활하지 않습니다")
                    }
                }
            }
        }
    }
    
    fileprivate func showErrorMessage(title: String, message: String) {
        let alertController = AlertController().createAlertController(title: title, message: message)
        
        let yes = UIAlertAction(title: "확인", style: .cancel)
        alertController.addAction(yes)
        present(alertController, animated: true)
    }
    
    fileprivate func setRegionLayout() {
        flowLayout.itemSize = CGSize(width: w*0.2, height: h*0.04)
        regionCollectionView.collectionViewLayout = flowLayout
        
        regionCollectionView.delegate = self
        regionCollectionView.dataSource = self
    }
    
    fileprivate func setTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
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

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return regionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = regionCollectionView.dequeueReusableCell(withReuseIdentifier: "RegionCell", for: indexPath) as! RegionCell
        cell.regionLabel.text = regionArray[indexPath.row]
        cell.regionContentView.layer.cornerRadius = 5
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        as! RegionCell
        
        if cell.clickCount == 1 {
            cell.clickCount = 0
            regionValue = ""
        }
        else {
            regionValue = regionArray[indexPath.row]
            cell.clickCount += 1
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModel.storeList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.name.text = userViewModel.storeList![indexPath.row].name
        cell.address.text = userViewModel.storeList![indexPath.row].address!.street! + " " + userViewModel.storeList![indexPath.row].address!.city!
        
        cell.congestionStatus.text = setStringValue(enumValue: userViewModel.storeList![indexPath.row].congestionStatus!)
        
        cell.numberOfTables.text = "\(userViewModel.storeList![indexPath.row].useTables!) / \(userViewModel.storeList![indexPath.row].numberOfTables!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "UserPage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detailViewController") as! detailViewController
        vc.shopId = userViewModel.storeList![indexPath.row].id ?? -1
        present(vc, animated: true)
    }
    
    
}

class RegionCell: UICollectionViewCell {
    
    @IBOutlet weak var regionContentView: UIView!
    @IBOutlet weak var regionLabel: UILabel!
    
    var clickCount: Int = 0 {
        didSet {
            if clickCount == 0{
                regionContentView.backgroundColor = UIColor.lightGray
            } else {
                regionContentView.backgroundColor = #colorLiteral(red: 0.8799410462, green: 0.2819583118, blue: 0.2278155088, alpha: 1)
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if !isSelected {
                regionContentView.backgroundColor = UIColor.lightGray
                clickCount = 0
            }
        }
    }
}

class SearchCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var numberOfTables: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var congestionStatus: UILabel!
}
