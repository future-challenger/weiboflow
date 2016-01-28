//
//  WeiboTextCell.swift
//  CollectionViewDemo
//
//  Created by Bruce Lee on 26/1/2016.
//  Copyright © 2016 Dynamic Cell. All rights reserved.
//

import UIKit

class WeiboTextCell: UICollectionViewCell {
    @IBOutlet weak var weiboTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // this method is still get called.
    }
    
    func setCellWidth(width: CGFloat) {
        weiboTextLabel.preferredMaxLayoutWidth = width
    }
}
