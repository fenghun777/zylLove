//
//  SignInViewController.swift
//  zylLove
//
//  Created by yy z on 2018/2/6.
//  Copyright © 2018年 zyl. All rights reserved.
//

import UIKit

class SignInViewController: ZyBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let lblSign:UILabel = UILabel.initWith(title: "熟练度附近sdddf123123", font: 18, color: UIColor.white, bgColor: UIColor.brown, radius: 5);
        self.view.addSubview(lblSign);
        lblSign.snp.makeConstraints { (make) in
            make.center.equalTo(self.view);
            make.size.equalTo(CGSize(width:220, height:160))
        }
        lblSign.layer.masksToBounds = true;
        lblSign.layer.borderColor = UIColor.red.cgColor
        lblSign.layer.borderWidth = 2;
        
        let lblS:UILabel = UILabel.initWith(title: "熟练度附近sdddf123123", font: 18, color: UIColor.white, bgColor: UIColor.brown, radius: 5);
        self.view.addSubview(lblS);
        lblS.snp.makeConstraints { (make) in
            make.top.equalTo(lblSign.snp.bottom).offset(10)
            make.centerX.equalTo(self.view);
            make.size.equalTo(CGSize(width:220, height:160))
        }
        lblS.layer.masksToBounds = true;
        lblS.layer.borderColor = UIColor.red.cgColor
        lblS.layer.borderWidth = 2;
        lblS.font = FONT(size: 26, name: 1, bold: 15, italic: 12)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
