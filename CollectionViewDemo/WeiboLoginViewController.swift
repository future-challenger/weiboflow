//
//  WeiboLogin.swift
//  CollectionViewDemo
//
//  Created by Bruce Lee on 24/1/2016.
//  Copyright © 2016 Dynamic Cell. All rights reserved.
//

import UIKit

class WeiboLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    @IBAction func weiboLoginAction(sender: UIButton) {
        let request = WBAuthorizeRequest.request() as? WBAuthorizeRequest
        if let _ = request {
            request?.redirectURI = CommonUtil.WEIBO_REDIRECT_URL
            request?.scope = "all"
            request?.userInfo = ["SSO_form": "request"]
            WeiboSDK.sendRequest(request)
        }
    }
}
