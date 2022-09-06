//
//  LocalizableViewController.swift
//  SeSacWek9
//
//  Created by useok on 2022/09/06.
//

import UIKit
import CoreLocation
import MessageUI // 메일로 문의 보내기, 디바이스에서만 가능(시뮬은안됨.)

class LocalizableViewController: UIViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sampleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.title = NSLocalizedString("navigation_title", comment: "")
        navigationItem.title = "navigation_title".localized
        
        searchBar.placeholder =  "search_placeholder".localized
        inputTextField.placeholder = "textField_placeholder".localized
        
        let buttonTitle = NSLocalizedString("common_cancel", comment: "")
        sampleButton.setTitle(buttonTitle, for: .normal)
        
//        CLLocationManager().requestWhenInUseAuthorization() //위치권한
        sampleButton.addTarget(self, action: #selector(clicked), for: .touchUpInside)
 
        
        
        //저는 잭입니다.
        // i am jack.
        
        myLabel.text = String(format: NSLocalizedString("introduce", comment: ""), "고래밥")
        inputTextField.text = String(format: NSLocalizedString("number_test", comment: ""), 11)
        
        myLabel.text = "introduce".localized(with: "고래밥")
        inputTextField.text = "number_test".localized(with: 20)

    }
    @objc func clicked() {
        sendMail()
    }
    
    // 리뷰남기기- > 리뷰앨럿: 1년에 한 디바이스당 3회    SKStoreReviewController참고
    // 문의남기기 -> 횟수제한x,
    func sendMail() {
        if MFMailComposeViewController.canSendMail() { //VC통해 구현가능하면?
            //메일 띄우기
            let mail = MFMailComposeViewController()
            mail.setToRecipients(["wooseokbird@gmail.com"])
            mail.setSubject("제목: 고래밥 다이어리 문의사항 ~~")//제목
            mail.mailComposeDelegate = self
            self.present(mail, animated: true)
        }else {
            //alert. 메일등록해주고거나 wooseokbird@gmail.com로 문의주세요
            print("alert")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled: //쓰다가 취소
            print(2)
        case .saved: // 임시저장
            print(2)
        case .sent: // 전달이됨
            print(2)
        case .failed: // 보냇는데 실패
            print(2)
        }
        controller.dismiss(animated: true)
    }
    
}



extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized<T> (with: T) -> String {
//        return String(format: NSLocalizedString("introduce", comment: ""), "고래밥")
        return String(format: self.localized, with as! CVarArg)
    }
    
    
    
}
