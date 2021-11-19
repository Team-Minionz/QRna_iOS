//
//  ConfusionViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/10/14.
//

import UIKit

class ConfusionViewController: UIViewController, MTMapViewDelegate {
    
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet var subView: ContentView!
    @IBOutlet var mapStackView: UIStackView!
    @IBOutlet var confusionBtn: RadioButton!
    @IBOutlet var distanceBtn: RadioButton!
    
    var mapView: MTMapView?
    var mapPoint1: MTMapPoint?
    var poiItem1: MTMapPOIItem?
    var latitude = 27.0
    var longitude = 204.0
    var sortValue = "default"
    let storeViewModel = StoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confusionBtn?.alternateButton = [distanceBtn!]
        distanceBtn?.alternateButton = [confusionBtn!]
        distanceBtn.isSelected = true
        setMapView()
        mainTable.delegate = self
        mainTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getStoreData()
    }
    
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        let currentLocation = location?.mapPointGeo()
        print("갱신")
        if let latitude = currentLocation?.latitude, let longitude = currentLocation?.longitude{
            print("MTMapView updateCurrentLocation (\(latitude),\(longitude)) accuracy (\(accuracy))")
        }
    }
    
    @IBAction func didTapConfusionBtn(_ sender: Any) {
        sortValue = "congestion"
        getStoreData()
    }
    
    @IBAction func didTapDistanceBtn(_ sender: Any) {
        sortValue = "default"
        getStoreData()
    }
    
    fileprivate func getStoreData() {
        storeViewModel.getStoreList(latitude: self.latitude, longitude: self.longitude, sort: self.sortValue) { result in
            switch result {
            case .success:
                self.mapStackView.isHidden = false
                self.setMapView()
                self.mainTable.reloadData()
            case .failure:
                //self.mapStackView.isHidden = true
                print("실패")
            }
        }
    }
    
    fileprivate func setMapView() {
        mapView = MTMapView(frame: subView.layer.bounds)
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            
            // 현재 위치 트래킹
            mapView.currentLocationTrackingMode = .onWithoutHeading
            mapView.showCurrentLocationMarker = true
            mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude:  37.456518177069526, longitude: 126.70531256589555)), zoomLevel: 5, animated: true)
            mapView.layer.cornerRadius = 10
            self.subView.addSubview(mapView)
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
    
    fileprivate func makeMarker(){
        var cnt = 0
        for item in storeViewModel.storeArray {
            self.mapPoint1 = MTMapPoint(geoCoord: MTMapPointGeo(latitude: item.latitude ?? 0, longitude: item.longitude ?? 0))
            poiItem1 = MTMapPOIItem()
            // 핀 색상 설정
            poiItem1?.markerType = MTMapPOIItemMarkerType.redPin
            poiItem1?.mapPoint = mapPoint1
            // 핀 이름 설정
            poiItem1?.itemName = item.name
            // 태그 설정
            poiItem1?.tag = cnt
            // 맵뷰에 추가!
            mapView!.add(poiItem1)
            cnt += 1
        }
    }
}

extension ConfusionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.storeViewModel.storeArray.count == 0{
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
class ConfusionCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var tableStatus: UILabel!
    @IBOutlet weak var confuse: UILabel!
}
