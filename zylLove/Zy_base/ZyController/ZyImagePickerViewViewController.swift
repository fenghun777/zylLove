//
//  ZyImagePickerViewViewController.swift
//  sk.charging_ios
//
//  Created by iosdev1 on 2017/10/11.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import UIKit

class ZyImagePickerViewViewController: ZyBaseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    //    相册
    var alertC:UIAlertController? = nil
    var imagePicker:UIImagePickerController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //    相册部分
    func imageActionsheetUI() -> Void {
        alertC = UIAlertController.init(title: "获取照片", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cancelA = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel) { (action) in

        }
        let xjA = UIAlertAction.init(title: "相机", style: UIAlertActionStyle.destructive) { (action) in
            self.getImageFromCamera()
        }
        let xcA = UIAlertAction.init(title: "相册", style: UIAlertActionStyle.default) { (action) in
            self.getImageFromIpc()
        }
        alertC?.addAction(cancelA)
        alertC?.addAction(xjA)
        alertC?.addAction(xcA)
        self.present(alertC!, animated: true) {}
    }
    //打开相机
    func getImageFromCamera() -> Void {

        // 1.判断相册是否可以打开
        if  (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            // 2. 创建图片选择控制器
            imagePicker = UIImagePickerController.init()
            // 照相机
            imagePicker?.sourceType = UIImagePickerControllerSourceType.camera
            // 4.设置代理
            imagePicker?.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            self.present(imagePicker!, animated: true, completion: { })
        }
    }

    func getImageFromIpc() -> Void {
        // 1.判断相册是否可以打开
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            // 2. 创建图片选择控制器
            imagePicker = UIImagePickerController.init()
            // 3. 设置打开照片相册类型(显示所有相簿)
            imagePicker?.sourceType = UIImagePickerControllerSourceType.photoLibrary //savedPhotosAlbum
            // 4.设置代理
            imagePicker?.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            self.present(imagePicker!, animated: true, completion: { })
        }
    }

    //    MARK: UIImagePickerControllerDelegate

    // 获取图片后的操作
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let dicInfo:Dictionary <String, Any> = info
        let imageSource:UIImage = dicInfo[UIImagePickerControllerOriginalImage] as! UIImage
        api_uploadUploadImage(image: imageSource, SuccessClosure: { (model) in
            self.uploadImageSuccess(model: model);
            self.dismiss(animated: true, completion: nil)
        }) { (error) in
            echo(data: "上传失败");
            self.dismiss(animated: true, completion: nil)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: {})
    }

    func uploadImageSuccess(model:UploadImageModel) -> Void {
        echo(data: "\(model)")
    }
}
