//
//  ZyBaseTableView.swift
//  sk.charging_ios
//
//  Created by iosdev1 on 2017/9/26.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import UIKit

class ZyBaseTableView: UITableView ,UITableViewDelegate ,UITableViewDataSource {

    var mainData = Array<Any>.init()

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.initView()
        self.initData()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initView() -> Void {
        self.backgroundColor = COLOR_BACKGROUND
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = UITableViewCellSeparatorStyle.singleLine//分割线
    }

    func initData() -> Void {

    }

    // MARK:代理方法分类 UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainData.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellid";
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = ZyBaseTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellId);
        }
        return cell!;
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //        左划，点击删除触发
        //        mainData.remove(at: indexPath.row)
        //        tableView.reloadData();
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }

    //    左划出现删除和收藏
    //    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    //        let collection:UITableViewRowAction = UITableViewRowAction.init(style: UITableViewRowActionStyle.default, title: "收藏") { (action, index) in
    //            echo(data: "\(index)")
    //        }
    //        collection.backgroundColor = UIColor.orange
    //
    //        let delete = UITableViewRowAction.init(style: UITableViewRowActionStyle.destructive, title: "删除") { (action, index) in
    //            echo(data: "\(index)")
    //        }
    //
    //        let add = UITableViewRowAction.init(style: UITableViewRowActionStyle.destructive, title: "添加") { (action, index) in
    //            echo(data: "\(index)")
    //        }
    //        return [collection, delete, add]
    //    }

    // MARK:代理方法分类    UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45;
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView:UIView = UIView.init()
        headView.backgroundColor = COLOR_BACKGROUND
        return headView;
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1;
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView:UIView = UIView.init()
        footView.backgroundColor = COLOR_BACKGROUND
        return footView;
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}
