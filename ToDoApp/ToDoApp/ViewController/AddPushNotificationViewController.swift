//
//  AddPushNotificationViewController.swift
//  ToDoApp
//
//  Created by Darshan on 13/10/21.
//

import UIKit

class AddPushNotificationViewController: UIViewController {

    @IBOutlet weak var txtNotificationName:UITextField!
    @IBOutlet weak var txtNotificationDateAndTime:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
extension  AddPushNotificationViewController{
    func isValidNotification()->Bool{
        guard let _ = self.txtNotificationName.text else{
            return false
        }
        guard let _ = self.txtNotificationDateAndTime.text else{
            return false
        }
        return  true
    }
    @IBAction func buttonSubmitPushNotification(sender:UIButton){
        if self.isValidNotification(){
            
        }
    }
    func addPushNotification(){
        
    }
    @IBAction func buttonClosePopup(sender:UIButton){
        
    }
}
