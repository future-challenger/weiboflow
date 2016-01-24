//
//  HomeViewController.swift
//  CollectionViewDemo
//
//  Created by Bruce Lee on 24/1/2016.
//  Copyright © 2016 Dynamic Cell. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let userDefaults = NSUserDefaults.standardUserDefaults()
        let userLoginStatus = userDefaults.objectForKey("UseLoginStatus") as? String
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let weiboLoginController = storyBoard.instantiateViewControllerWithIdentifier("weiboLoginController")
        if userLoginStatus == nil {
            self .presentViewController(weiboLoginController, animated: true, completion: nil)
        }
        
//        let userDefaults = NSUserDefaults.standardUserDefaults()
//        let userModel = UserModel(uId: "123456", un: "Jack")
//        userDefaults.setObject(userModel, forKey: "UserInfoKey")
//        userDefaults.synchronize()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class UserModel {
        var userId: String?
        var userName: String?
        
        init(uId: String, un: String) {
            userId = uId
            userName = un
        }
    }
}
