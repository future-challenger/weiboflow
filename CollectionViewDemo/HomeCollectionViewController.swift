//
//  HomeCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by Bruce Lee on 24/1/2016.
//  Copyright © 2016 Dynamic Cell. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

//private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController {

    private let reuseIdentifier = "DemoCell"
    private let sectionInsets = UIEdgeInsets(top: 50, left: 20, bottom: 50, right: 20)
    private var timeLineStatus: [StatusModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let weiboLoginInfo = NSUserDefaults.standardUserDefaults().getCustomObject(forKey: CommonUtil.WEIBO_USER) as? WeiboUserModel
        let parameters: [String: String]?
        if let weiboUserInfo = weiboLoginInfo {
            parameters = ["access_token": weiboUserInfo.accessToken ?? "",
                          "source": ConstantUtil.WEIBO_APPKEY]
            Alamofire.request(.GET, "https://api.weibo.com/2/statuses/public_timeline.json", parameters: parameters, encoding: .URL, headers: nil)
                .responseString(completionHandler: {response in
//                    print("response:- \(response)")
                    let statuses = Mapper<BaseModel>().map(response.result.value)
                    print("total number: \(statuses!.totalNumber)")
                    if let timeLine = statuses where timeLine.totalNumber > 0 {
                        self.timeLineStatus = timeLine.statuses
                        self.collectionView?.reloadData()
                    }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.timeLineStatus?.count ?? 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    

    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
