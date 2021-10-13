//
//  AddPushNotificationViewController.swift
//  ToDoApp
//
//  Created by Darshan on 13/10/21.
//

import UIKit
import UserNotifications
protocol AddPushNotification {
    func pushNotificationAdded()
}
class AddPushNotificationViewController: UIViewController {

    @IBOutlet weak var txtNotificationName:UITextField!
    @IBOutlet weak var txtNotificationDateAndTime:UITextField!
    
    var fromDatePicker:UIDatePicker = UIDatePicker()
    var fromDatePickerToolbar:UIToolbar = UIToolbar()
    
    var delegate:AddPushNotification?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setup()
    }
    func setup(){
        self.fromDatePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        self.configureFormDatePicker()
    }
    func configureFormDatePicker(){
            
            self.fromDatePickerToolbar.sizeToFit()
            self.fromDatePickerToolbar.layer.borderColor = UIColor.clear.cgColor
            self.fromDatePickerToolbar.layer.borderWidth = 1.0
            self.fromDatePickerToolbar.clipsToBounds = true
            self.fromDatePickerToolbar.backgroundColor = UIColor.white
            self.fromDatePicker.datePickerMode = .dateAndTime
            self.fromDatePicker.minimumDate = Date()
            
            let doneButton = UIBarButtonItem(title:"Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(AddPushNotificationViewController.doneFormDatePicker))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            
            let title = UILabel.init()
            title.attributedText = NSAttributedString.init(string: "Task Date", attributes:[NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17)])
            
            title.sizeToFit()
            let cancelButton = UIBarButtonItem(title:"Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(AddPushNotificationViewController.cancelFormDatePicker))
            self.fromDatePickerToolbar.setItems([cancelButton,spaceButton,UIBarButtonItem.init(customView: title),spaceButton,doneButton], animated: false)
            
            
        self.txtNotificationDateAndTime.inputView = self.fromDatePicker
            self.txtNotificationDateAndTime.inputAccessoryView = self.fromDatePickerToolbar
        }
        @objc func doneFormDatePicker(){
            let date =  self.fromDatePicker.date
                DispatchQueue.main.async {
                    self.txtNotificationDateAndTime.text = date.getFormatted()
                    self.txtNotificationDateAndTime.resignFirstResponder()
                }
            //dismiss date picker dialog
            DispatchQueue.main.async {
                self.view.endEditing(true)
            }
        }
        @objc func cancelFormDatePicker(){
            DispatchQueue.main.async {
                self.view.endEditing(true)
            }
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
        guard let strTask = self.txtNotificationName.text,strTask.count > 0 else{
            UIAlertController.showAlertWithOkButton(self, aStrTitle: "ToDo List", aStrMessage: "Please add todo tasks", completion: nil)
            return false
        }
        guard let strTaskDate = self.txtNotificationDateAndTime.text, strTaskDate.count > 0 else{
            UIAlertController.showAlertWithOkButton(self, aStrTitle: "ToDo List", aStrMessage:  "Please add todo task Date ", completion: nil)
            return false
        }
        return  true
    }
    @IBAction func buttonSubmitPushNotification(sender:UIButton){
        if self.isValidNotification(){
            self.addPushNotification()
        }
    }
    func addPushNotification(){
           let content = UNMutableNotificationContent()
           content.title = "ToDo \(self.fromDatePicker.date)"
           content.body = "\(self.txtNotificationName.text!)"
           content.sound = UNNotificationSound.default
           content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
            let componentsFromDate = Calendar.current.dateComponents(in: TimeZone.current, from: self.fromDatePicker.date)
            let trigger = UNCalendarNotificationTrigger.init(dateMatching: componentsFromDate, repeats: true)
           let request = UNNotificationRequest.init(identifier: "\(self.fromDatePicker.date)", content: content, trigger: trigger)
           // Schedule the notification.
           let center = UNUserNotificationCenter.current()
           center.add(request)
           kAppDelegate!.arrayListOfNotification.append(request)
        self.delegate!.pushNotificationAdded()
          self.dismiss(animated: true, completion: nil)
    }
    @IBAction func buttonClosePopup(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}
