//
//  Constant.swift
//  ToDoApp
//
//  Created by Darshan on 13/10/21.
//

import Foundation
import UIKit
let kAppDelegate = UIApplication.shared.delegate as? AppDelegate 
let kUserDefault = UserDefaults.standard
let kUserDetail = "UserDetail"

extension UIStoryboard{
    class var main:UIStoryboard{
        return  UIStoryboard.init(name: "Main", bundle: nil)
    }
}
extension UIAlertController{
    class func showAlertWithOkButton(_ controller : AnyObject ,
                                     aStrTitle :String?,
                                     aStrMessage :String? ,
                                     completion : ((Int, String) -> Void)?) -> Void {
        
        self.showAlert(controller, aStrTitle: aStrTitle, aStrMessage: aStrMessage, style: .alert, aCancelBtn: nil, aDistrutiveBtn: nil, otherButtonArr: ["OK"], completion: completion)
        
    }
    class func showAlert(_ controller : AnyObject ,
                         aStrTitle :String? ,
                         aStrMessage :String? ,
                         style : UIAlertController.Style ,
                         aCancelBtn :String? ,
                         aDistrutiveBtn : String?,
                         otherButtonArr : Array<String>?,
                         completion : ((Int, String) -> Void)?) -> Void {
        
        
        let alert = UIAlertController.init(title: aStrTitle, message: aStrMessage, preferredStyle: style)
        
        if let strDistrutiveBtn = aDistrutiveBtn {
            
            let aStrDistrutiveBtn = strDistrutiveBtn
            
            alert.addAction(UIAlertAction.init(title: aStrDistrutiveBtn, style: .destructive, handler: { (UIAlertAction) in
                
                completion?(otherButtonArr != nil ? otherButtonArr!.count : 0, strDistrutiveBtn)
                
            }))
        }
        
        if let strCancelBtn = aCancelBtn {
            
            let aStrCancelBtn = strCancelBtn
            
            alert.addAction(UIAlertAction.init(title: aStrCancelBtn, style: .cancel, handler: { (UIAlertAction) in
                
                if ( aDistrutiveBtn != nil ) {
                    completion?(otherButtonArr != nil ? otherButtonArr!.count + 1 : 1, strCancelBtn)
                } else {
                    completion?(otherButtonArr != nil ? otherButtonArr!.count : 0, strCancelBtn)
                }
                
            }))
        }
        
        if let arr = otherButtonArr {
            
            for (index, value) in arr.enumerated() {
                
                let aValue = value
                
                alert.addAction(UIAlertAction.init(title: aValue, style: .default, handler: { (UIAlertAction) in
                    
                    completion?(index, value)
                    
                }))
            }
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            
            
            alert.popoverPresentationController?.sourceView = controller.view// works for both iPhone & iPad
            
            controller.present(alert, animated: true, completion: nil)

        }
        else{
            
            controller.present(alert, animated: true, completion: nil)
        }
        
        
    }

}
extension Date{
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
     func getFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // This formate is input formated .
        let strDate = dateFormatter.string(from: self.toLocalTime())
        var formateDate = dateFormatter.date(from: strDate)
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a" // Output Formated
        
        return dateFormatter.string(from: formateDate!)
    }
}

