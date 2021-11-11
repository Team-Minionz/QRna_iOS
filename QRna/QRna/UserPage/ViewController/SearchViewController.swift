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
            if regionValue == "" {
                userViewModel.searchStore(keyword: keywordLabel.text!) { response in
                    switch response {
                    case .success:
                        print("키워드 검색 성공")
                    case .failure:
                        print("키워드 검색 실패")
                    }
                }
            }
            
            else {
                userViewModel.searchStoreWithRegion(keyword: keywordLabel.text!, region: regionValue) { response in
                    switch response {
                    case .success:
                        print("키워드/지역 검색 성공")
                    case .failure:
                        print("키워드/지역 검색 실패")
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
