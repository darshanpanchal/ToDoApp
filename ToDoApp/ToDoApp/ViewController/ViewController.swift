//
//  ViewController.swift
//  ToDoApp
//
//  Created by Darshan on 13/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageUser:UIImageView!
    @IBOutlet weak var lblUserName:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setup()
        print(UIApplication.shared.scheduledLocalNotifications)
    }
    func setup(){
        //Navigation
        self.title = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        //Device Configuration
        self.lblUserName.text = UIDevice.current.name
    }
    //Navigation
    func presentAddToDoPopUpController(){
        
    }
}
//Selector Methods
extension ViewController{
    @IBAction func buttonAddToDoSelector(sender:UIButton){
        
    }
}

