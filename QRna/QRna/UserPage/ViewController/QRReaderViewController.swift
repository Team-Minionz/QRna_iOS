//
//  QRReaderViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/10/14.
//

import UIKit

class QRReaderViewController: UIViewController, ReaderViewDelegate {
    func readerComplete(status: ReaderStatus) {
        print("완료")
    }
    

    
    @IBOutlet weak var rv: RV!
    let qrViewModel = QRViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rv.delegate = self
        self.rv.start()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
}
