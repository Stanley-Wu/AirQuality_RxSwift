//
//  IndentionCell.swift
//  UIComponent
//
//  Created by Dlink on 2018/2/26.
//  Copyright © 2018年 Stanley. All rights reserved.
//

import UIKit

class IndentionCell: UITableViewCell {

    var margin: CGFloat = 0.0
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            let x = newFrame.origin.x + margin
            let width = newFrame.width - 2 * margin
            let resizeFrame = CGRect(origin: CGPoint(x: x, y: newFrame.origin.y), size: CGSize(width: width, height: newFrame.height))
            super.frame = resizeFrame
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
