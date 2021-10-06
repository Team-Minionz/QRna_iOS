//
//  ViewController.swift
//  QRna
//
//  Created by 이명직 on 2021/09/30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var readerView: ReaderView!
    @IBOutlet weak var captureBtn: UIButton!
    
    let userViewModel = UserViewModel()
    let qrViewModel = QRViewModel()
    
    var testId = "b@b.b"
    var testPass = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.readerView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if !self.readerView.isRunning {
            self.readerView.stop(isButtonTap: false)
        }
    }
    @IBAction func didTapSignIn(_ sender: Any) {
        userViewModel.signIn(email: testId, password: testPass) {
            result in
            switch result {
            case .success:
                print("로그인 성공")
            case .failure:
                print("로그인 실패")
            }
        }
    }
    @IBAction func didTapSignUp(_ sender: Any) {
        userViewModel.signUp(name: "남궁재성", email: testId, nickName: "두부", telNumber: "010-1234-3455", password: testPass) {
            result in
            switch result {
            case .success:
                UserViewModel.userEmail = self.testId
                print("성공")
            case .failure:
                print("실패")
            }
            
        }
    }
    @IBAction func didTapWithdraw(_ sender: Any) {
        userViewModel.withdraw { result in
            switch result {
            case .success:
                print("탈퇴 성공")
            case .failure:
                print("탈퇴 실패")
            }
        }
    }
    @IBAction func didTapLogout(_ sender: Any) {
    }
    
    @IBAction func didTabCaptureBtn(_ sender: UIButton) {
        
        if self.readerView.isRunning {
            self.readerView.stop(isButtonTap: true)
        } else {
            self.readerView.start()
        }
        
        sender.isSelected = self.readerView.isRunning
        
    }
    
}

extension ViewController: ReaderViewDelegate {
    func readerComplete(status: ReaderStatus) {
        
        var title = ""
        var message = ""
        switch status {
        case let .success(code):
            guard let code = code else {
                title = "에러"
                message = "QR코드를 인식하지 못했습니다.\n다시 시도해주세요."
                break
            }
            
            title = "알림"
            message = "인식성공\n\(code)"
            qrViewModel.certificationQR(userEmail: testId, shopTelNumber: code) { result in
                switch result {
                case .success:
                    print("QR 통신 성공")
                case .failure:
                    print("QR 통신 실패")
                }
                
            }
        
        case .fail:
            title = "에러"
            message = "QR코드를 인식하지 못했습니다.\n다시 시도해주세요."
        case let .stop(isButtonTap):
            if isButtonTap {
                title = "알림"
                message = "바코드 읽기를 멈추었습니다."
                self.captureBtn.isSelected = readerView.isRunning
            } else {
                self.captureBtn.isSelected = readerView.isRunning
                return
            }
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
