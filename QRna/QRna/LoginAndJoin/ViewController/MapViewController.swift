//
//  MapViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/11/16.
//

import UIKit

class MapViewController: UIViewController, MTMapViewDelegate {

    
    @IBOutlet var subView: UIView!
    
    var mapView: MTMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MTMapView(frame: subView.frame)
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard

            // 현재 위치 트래킹
            mapView.currentLocationTrackingMode = .onWithoutHeading
            mapView.showCurrentLocationMarker = true
            mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude:  37.456518177069526, longitude: 126.70531256589555)), zoomLevel: 5, animated: true)
            self.subView.addSubview(mapView)
        }
    }
}
