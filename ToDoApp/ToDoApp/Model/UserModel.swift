//
//  UserModel.swift
//  ToDoApp
//
//  Created by Darshan on 13/10/21.
//

import Foundation
import UIKit

class UserDetail: NSObject {

    var listOfNotification:[UNNotificationRequest] = []
    
    private enum CodingKeys: String, CodingKey {
        case listOfNotification
    }
    init(notification:[UNNotificationRequest]){
        super.init()
        self.listOfNotification = notification
    }
   
}
extension UserDetail{
    
   
    static var isUserLoggedIn:Bool{
        if let userDetail  = kUserDefault.value(forKey: kUserDetail) as? UserDetail{
            return true
        }else{
          return false
        }
    }
    func setuserDetailToUserDefault(){
        do{
            kUserDefault.setValue(self, forKey:kUserDetail)
            kUserDefault.synchronize()
        }catch{
            
        }
    }
    
    static func getUserFromUserDefault() -> UserDetail?{
        if let userDetail = kUserDefault.value(forKey: kUserDetail) as? UserDetail{
            return userDetail
            /*
            do {
                let user:UserDetail = try JSONDecoder().decode(UserDetail.self, from: userDetail)
                return user
            }catch{
               
                return nil
            }*/
        }
       
        return nil
    }
    static func removeUserFromUserDefault(){
        kUserDefault.removeObject(forKey:kUserDetail)
    }
}
