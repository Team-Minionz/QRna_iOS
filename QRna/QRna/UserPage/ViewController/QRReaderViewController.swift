//
//  QRReaderViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/10/14.
//

import UIKit
import AVFoundation

class QRReaderViewController: UIViewController {
    
    @IBOutlet var readerView: ReaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.readerView.delegate = self
        
        self.readerView.start()
        
    }
}

extension QRReaderViewController: ReaderViewDelegate {
    func readerComplete(status: ReaderStatus) {
        
        var title = ""
        var message = ""
        switch status {
        case let .success(code):
            guard let code = code else {
                title = "에러"
                message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
                break
            }
            
            title = "알림"
            message = "인식성공\n\(code)"
        case .fail:
            title = "에러"
            message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
        case let .stop(isButtonTap):
            if isButtonTap {
                title = "알림"
                message = "바코드 읽기를 멈추었습니다."
                
                return
            }
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
