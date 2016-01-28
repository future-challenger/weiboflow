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
import SDWebImage
import CHTCollectionViewWaterfallLayout

//private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let reuseIdentifier = "DemoCell"
    private let reuseTextIdentifier = "DemoTextCell"

    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    private var timeLineStatus: [StatusModel]?
    
    private var cellWidth: CGFloat {
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        return (screenWidth - 40) / 2
    }
    
    private let staticLabel: UILabel = UILabel()
    private var staticImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(WeiboImageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//        self.collectionView!.registerClass(WeiboTextCell.self, forCellWithReuseIdentifier: reuseTextIdentifier)

        // Do any additional setup after loading the view.
        
//        staticWeiboTextCell = self.collectionView?.dequeueReusableCellWithReuseIdentifier(reuseTextIdentifier, forIndexPath: NSIndexPath(forItem: 0, inSection: 0)) as? WeiboTextCell
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let weiboLoginInfo = NSUserDefaults.standardUserDefaults().getCustomObject(forKey: CommonUtil.WEIBO_USER) as? WeiboUserModel
        let parameters: [String: String]?
        if let weiboUserInfo = weiboLoginInfo {
            parameters = ["access_token": weiboUserInfo.accessToken ?? "",
                          "source": ConstantUtil.WEIBO_APPKEY]
            Alamofire.request(.GET, "https://api.weibo.com/2/statuses/friends_timeline.json", parameters: parameters, encoding: .URL, headers: nil)
                .responseString(completionHandler: {response in
                    print("response:- \(response)")
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
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1    //1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.timeLineStatus?.count ?? 0 //2
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let status = self.getWeiboStatus(indexPath)
        var cell: UICollectionViewCell = UICollectionViewCell()
        
        guard let _ = status.status else {
            cell.backgroundColor = UIColor.darkTextColor()
            return cell
        }
        
        if status.hasImage == 1 {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
            let weiboImageCell = cell as! WeiboImageCell
//            weiboImageCell.weiboImageView.image =
            weiboImageCell.weiboImageView.backgroundColor = UIColor.blueColor()
            weiboImageCell.weiboImageView.sd_setImageWithURL(NSURL(string: status.status?.bmiddlePic ?? ""))
            
        } else if status.hasImage == 0 {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseTextIdentifier, forIndexPath: indexPath)
            let weiboTextCell = cell as! WeiboTextCell
            weiboTextCell.setCellWidth(self.cellWidth)
            weiboTextCell.weiboTextLabel.text = status.status?.weiboText ?? ""
            weiboTextCell.contentView.backgroundColor = UIColor.orangeColor()
            weiboTextCell.weiboTextLabel.backgroundColor = UIColor.redColor()
        } else {
            cell = UICollectionViewCell()
        }
    
        cell.backgroundColor = UIColor.orangeColor() //3
    
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let status = self.getWeiboStatus(indexPath)
//        guard let _ = status.status else {
//            return CGSize(width: self.cellWidth, height: self.cellWidth)
//        }
//        
//        if status.hasImage == 0 {
//            staticLabel.text = status.status?.weiboText ?? ""
//            let height = self.staticLabel.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
//            
//            return CGSize(width: self.cellWidth, height: height)
//        }
        
        return CGSize(width: self.cellWidth, height: self.cellWidth)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    /**
     get status and if this status has image or not
     @return:
        status, one of the timeline
        Int, 1: there's image, 0: there's no image, -1: empty status
     */
    func getWeiboStatus(indexPath: NSIndexPath) -> (status: StatusModel?, hasImage: Int) {
        if let timeLineStatusList = self.timeLineStatus where timeLineStatusList.count > 0 {
            let status = timeLineStatusList[indexPath.item]
            if let middlePic = status.bmiddlePic where middlePic != "" {
                // there's middle sized image to show
                return (status, 1)
                
            } else {
                // start to consider text
                return (status, 0)
            }
        }
        
        return (nil, -1)
    }
    
    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
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
