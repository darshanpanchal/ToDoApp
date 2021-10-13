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
    
    @IBOutlet weak var lblProgress:UILabel!
    @IBOutlet weak var viewProgress:UISlider!
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func setup(){
        //Navigation
        self.title = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        //Device Configuration
        self.lblUserName.text = UIDevice.current.name
        //CollectionView
        self.configureCollectionView()
        
    }
    
    //Recycle View
    func configureCollectionView(){
        self.collectionView.register(UINib.init(nibName: "ToDoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ToDoCollectionViewCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
    //Navigation
    func presentAddToDoPopUpController(){
        if let addNotificationViewcontroller = UIStoryboard.main.instantiateViewController(identifier: "AddPushNotificationViewController") as? AddPushNotificationViewController{
            addNotificationViewcontroller.delegate = self
            addNotificationViewcontroller.modalPresentationStyle = .overFullScreen
            self.present(addNotificationViewcontroller, animated: false, completion: nil)
            
        }
    }
}
//Selector Methods
extension ViewController:AddPushNotification{
    @IBAction func buttonAddToDoSelector(sender:UIButton){
        self.presentAddToDoPopUpController()
    }
    func pushNotificationAdded() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
//Collection
extension ViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  kAppDelegate!.arrayListOfNotification.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoCollectionViewCell", for: indexPath) as! ToDoCollectionViewCell
            let objRequest =  kAppDelegate!.arrayListOfNotification[indexPath.item]
    
            cell.lblDate.text = objRequest.identifier
            cell.lblToDo.text = objRequest.content.body
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2 - 20 , height:collectionView.bounds.width/2 - 20)

    }
    
}
