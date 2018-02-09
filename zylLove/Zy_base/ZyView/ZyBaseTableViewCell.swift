//
//  ZyBaseTableViewCell.swift
//  mall.ios.shop
//
//  Created by iosdev1 on 2017/6/28.
//  Copyright © 2017年 ygsoft. All rights reserved.
//

import UIKit

class ZyBaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isUserInteractionEnabled = true
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func initView() -> Void {
        self.selectionStyle = UITableViewCellSelectionStyle.none//选中时取消选中状态        
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
