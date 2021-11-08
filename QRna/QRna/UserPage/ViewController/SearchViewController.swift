//
//  SearchViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/11/07.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var regionCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let regionArray = ["서울","인천","경기도","부산","제주도"]
    override func viewDidLoad() {
        super.viewDidLoad()

        setSearchBar()
        regionCollectionView.delegate = self
        regionCollectionView.dataSource = self
        searchBar.delegate = self
    }
    
    func setSearchBar(){
        
        searchBar.placeholder = "Search"
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            //서치바 백그라운드 컬러
            textfield.backgroundColor = UIColor.white
            //플레이스홀더 글씨 색 정하기
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            //서치바 텍스트입력시 색 정하기
            textfield.textColor = UIColor.black
            
        }
    }
    
    private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        dismissKeyboard()
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return regionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = regionCollectionView.dequeueReusableCell(withReuseIdentifier: "RegionCell", for: indexPath) as! RegionCell
        cell.regionLabel.text = regionArray[indexPath.row]
        cell.regionContentView.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        // #colorLiteral(red: 0.8799410462, green: 0.2819583118, blue: 0.2278155088, alpha: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        let cell = self.regionCollectionView.cellForItem(at: indexPath)
        if cell?.isSelected == false {
            cell?.isSelected = true
            cell?.layer.borderColor = UIColor.red.cgColor
            cell?.layer.borderWidth = 2
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        let cell = self.regionCollectionView.cellForItem(at: indexPath)
        if cell?.isSelected == true {
            cell?.isSelected = false
            cell?.layer.borderWidth = 0
            cell?.layer.borderColor = UIColor.clear.cgColor
        }
        return true
    }
}

class RegionCell: UICollectionViewCell {
    
    @IBOutlet weak var regionContentView: UIView!
    @IBOutlet weak var regionLabel: UILabel!
    
    
}
