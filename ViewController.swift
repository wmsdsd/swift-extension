//
//  viewController.swift
//
//  Created by cho on 2020/09/03.
//  Copyright © 2020 chominsu. All rights reserved.
//

import Foundation
import UIKit
import SwiftGifOrigin

extension UIViewController {

    /**
     hex코드 ex:#000000을 UIColor 로 바꾸어 주는 코드
     */
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    /**
     파라메터로 전달 받는 문자를 화면에 보여준다.
     */
    func showToast(message : String) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 130, y: self.view.frame.size.height-200, width: 260, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    /**
     true : 블루투스가 꺼져 있는 경우
     false : 통상적으로 메인에서 사용되는 경고 메세지 창
     */
    func showBluetoothAlert(flag flg:Bool) {
        let bluetoothAlert = self.storyboard?.instantiateViewController(identifier: Identifier.alertBluetooth) as! DialogAlertBluetooth
        bluetoothAlert.modalPresentationStyle = .overCurrentContext
        bluetoothAlert.isBluetoothOff = flg
        self.present(bluetoothAlert, animated: false, completion: nil)
    }
    
    func showCustomAlert(title main: String, subFirst sub1: String, subSecond sub2: String) {
        let alert = self.storyboard?.instantiateViewController(identifier: Identifier.alert) as! DialogAlert
        alert.modalPresentationStyle = .overCurrentContext
        alert.titleText = main
        alert.subText1 = sub1
        alert.subText2 = sub2
        self.present(alert, animated: false, completion: nil)
    }

    func showCustomAlert(image img: String, title main: String, subFirst sub1: String, subSecond sub2: String) {
        let alert = self.storyboard?.instantiateViewController(identifier: Identifier.alert) as! DialogAlert
        alert.modalPresentationStyle = .overCurrentContext
        alert.img = UIImage.gif(asset: img)
        alert.titleText = main
        alert.subText1 = sub1
        alert.subText2 = sub2
        self.present(alert, animated: false, completion: nil)
    }

    func showCustomAlert(title main: String, subFirst sub1: String, subSecond sub2: String, event handler: @escaping () -> Void) {
        let alert = self.storyboard?.instantiateViewController(identifier: Identifier.alert) as! DialogAlert
        alert.modalPresentationStyle = .overCurrentContext
        alert.titleText = main
        alert.subText1 = sub1
        alert.subText2 = sub2
        alert.buttonHandler = handler
        self.present(alert, animated: false, completion: nil)
    }

    func showCustomConfirm(titleText title:String, subFirst subOne:String, subSecond subTwo:String?, okHandler ok:@escaping () -> Void) {
        let confirm = self.storyboard?.instantiateViewController(identifier: Identifier.confirm) as! DialogConfirm
        confirm.modalPresentationStyle = .overCurrentContext
        confirm.confirmTitle = title
        confirm.subFirst = subOne
        confirm.subSecond = subTwo
        confirm.okButtonClickHandler = ok
        self.present(confirm, animated: false, completion: nil)
    }
    
    func showAlert(title name:String, message msg:String, okHandler ok:((UIAlertAction) -> Void)?, cancelHandler cancel:((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: name, message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: ok)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: false, completion: nil)
    }
    
    func getUserDefaultCustomList(forKey key:String) -> [Complex] {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data else { return [Complex]() }
        guard let list = try? PropertyListDecoder().decode(Array<Complex>.self, from: data) else { return [Complex]() }
        return list
    }
    
    func openAppSetting() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }else{
                    UIApplication.shared.openURL(url)
                }
            }
        }
        else {
            self.showAlert(title: "에러", message: "설정 화면으로 이동이 불가능합니다.", okHandler: nil, cancelHandler: nil)
        }
    }   
}
