//
//  HomeViewController.swift
//  CollectionViewDemo
//
//  Created by Bruce Lee on 24/1/2016.
//  Copyright © 2016 Dynamic Cell. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var weiboLoginInfo: WeiboUserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userDefaults = NSUserDefaults.standardUserDefaults()
        weiboLoginInfo = userDefaults.getCustomObject(forKey: CommonUtil.WEIBO_USER) as? WeiboUserModel
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let weiboLoginController = storyBoard.instantiateViewControllerWithIdentifier("weiboLoginController")
        if weiboLoginInfo == nil {
            self.presentViewController(weiboLoginController, animated: true, completion: nil)
        } else {
            let collectionController = self.storyboard?.instantiateViewControllerWithIdentifier("homeCollectionViewController")
            self.navigationController?.pushViewController(collectionController!, animated: true)
        }
        
        // register notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notificationAction:", name: ConstantUtil.WEIBO_LOGIN_NOTIFICATION, object: nil)
    }

    func notificationAction(noti: NSNotification) {
        if noti.name != ConstantUtil.WEIBO_LOGIN_NOTIFICATION {
            print("notification name is not - \(ConstantUtil.WEIBO_LOGIN_NOTIFICATION)")
            return
        }
        
        let collectionController = self.storyboard?.instantiateViewControllerWithIdentifier("homeCollectionViewController")
        self.navigationController?.pushViewController(collectionController!, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
