//
//  ConfusionViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/10/14.
//

import UIKit
import CoreLocation

class ConfusionViewController: UIViewController {

    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    let storeViewModel = StoreViewModel()
    var locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTable.delegate = self
        mainTable.dataSource = self
        
        setLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getStoreData()
    }
    
    fileprivate func getStoreData() {
        storeViewModel.getStoreList { result in
            switch result {
            case .success:
                self.mainTable.reloadData()
            case .failure:
                print("실패")
            }
        }
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
    
    fileprivate func setLocationManager() {
        locationManager.delegate = self
        // 거리 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 사용 허용 알림
        locationManager.requestWhenInUseAuthorization()
        // 위치 사용을 허용하면 현재 위치 정보를 가져옴
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        else {
            print("위치 서비스 허용 off")
        }
    }
}

extension ConfusionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.storeViewModel.storeArray.count == 0 {
            self.noDataLabel.isHidden = false
            self.mainTable.isHidden = true
        }
        else {
            self.noDataLabel.isHidden = true
            self.mainTable.isHidden = false
        }
        
        return storeViewModel.storeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTable.dequeueReusableCell(withIdentifier: "ConfusionCell", for: indexPath) as! ConfusionCell
        cell.name.text = storeViewModel.storeArray[indexPath.row].name
        cell.confuse.text = setStringValue(enumValue: storeViewModel.storeArray[indexPath.row].congestionStatus!)
        cell.address.text = "\(storeViewModel.storeArray[indexPath.row].address)"
        cell.tableStatus.text = "\(storeViewModel.storeArray[indexPath.row].useTables)/ \(storeViewModel.storeArray[indexPath.row].numberOfTables)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "UserPage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detailViewController") as! detailViewController
        vc.shopId = storeViewModel.storeArray[indexPath.row].id ?? -1
        present(vc, animated: true)
    }
}

extension ConfusionViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("위치 업데이트!")
            print("위도 : \(location.coordinate.latitude)")
            print("경도 : \(location.coordinate.longitude)")
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
        }
    }
    
    // 위치 가져오기 실패
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}

class ConfusionCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var tableStatus: UILabel!
    @IBOutlet weak var confuse: UILabel!
}
