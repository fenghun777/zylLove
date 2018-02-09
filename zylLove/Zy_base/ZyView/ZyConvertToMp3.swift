//
//  ZyConvertToMp3.swift
//  sk.charging_ios
//
//  Created by iosdev1 on 2017/11/4.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import UIKit
import AVFoundation

class ZyConvertToMp3: UIView {

    var audioRecorder: AVAudioRecorder? // 录音
    var audioPlayer: AVAudioPlayer? // 播放

    // 定义音频的编码参数, 决定录制音频文件的格式, 音质, 容量大小等, 建议采用AAC的编码方式
    let recordSettings = [AVSampleRateKey: NSNumber(value: Float(44100.0)), // 声音采样率
        AVFormatIDKey: NSNumber(value: kAudioFormatLinearPCM), // 编码格式
        AVNumberOfChannelsKey: NSNumber(value: 2), //采集音轨
        AVEncoderAudioQualityKey: NSNumber(value: Int32(AVAudioQuality.medium.rawValue)), // 音频质量
        AVLinearPCMBitDepthKey: NSNumber(value: 16),
        AVLinearPCMIsFloatKey: NSNumber(value: false),
        AVLinearPCMIsBigEndianKey: NSNumber(value: false)]

    fileprivate var mp3Path: String?
    fileprivate var cafPath: String?
    fileprivate var player: AVAudioPlayer?

    var timerInt:NSInteger = 0
    var timer:Timer? = nil

    typealias ConvertToMp3CloseClosure = (_ pathMp3:String, _ urlMp3:String) -> Void
    var convertToMp3CloseClosure:ConvertToMp3CloseClosure?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
        self.creatSession()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 创建会话
    func creatSession()
    {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            if let url: URL = self.directoryURL() {
                try audioRecorder = AVAudioRecorder(url: url, settings: recordSettings) // 初始化实例
            }
            audioRecorder?.prepareToRecord() // 准备录音
        } catch {
            echo(data: "错误")
        }
        self.startRecord()
    }

    // 定义并构建一个url来保存音频
    func directoryURL() -> URL? {
        cafPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        mp3Path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        mp3Path?.append("/temp.mp3")
        cafPath?.append("/temp.caf")

        return URL(fileURLWithPath: cafPath!)
    }

//    开始录音
    func startRecord() -> Void {
        if let isRecording: Bool = audioRecorder?.isRecording {
            if !isRecording {
                let audioSession = AVAudioSession.sharedInstance()
                do {
                    try audioSession.setActive(true)
                    audioRecorder?.record()
                    print("recordCaf!")
                } catch {

                }
            }
        }

        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerClick(sender:)), userInfo: "info", repeats: true)
    }

    //    停止录音
    func stopRecord() -> Void {
        audioRecorder?.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do {
//            设置之后声音变大，不然音量很小
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        } catch {

        }

        do {
            try audioSession.setActive(false)
            print("stopCaf!")
        } catch {

        }

        timerInt = 0
        let lblTimer:UILabel = self.viewWithTag(1000) as! UILabel
        lblTimer.text = String(timerInt)
        //                    停止计时器并移除
        timer?.fireDate = NSDate.distantFuture
        timer?.invalidate()
        timer = nil
    }

    //    播放caf
    func startPlayingCaf() -> Void {
        if let isRecording = audioRecorder?.isRecording {
            if (!isRecording)
            {
                do {
                    if let url = audioRecorder?.url {
                        try audioPlayer = AVAudioPlayer(contentsOf: url)
                    }
                    audioPlayer?.play()
                    print("playCaf!")
                } catch {

                }
            }
        }
    }

    func convertToMP3() -> Void {
        let audioWrapper: AudioWrapper = AudioWrapper()
        // 录音.caf文件转换为MP3
        audioWrapper.convertSourcem4a(cafPath, outPutFilePath: mp3Path) { (a:String?) in
            print("转换成功");
        }
        print(cafPath!)
        print(mp3Path!)
        print("toMp3")
    }

    func playMp3() -> Void {
        do {
            self.player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: self.mp3Path!), fileTypeHint: "mp3")
        } catch {
            print("出现异常")
        }
        player?.play()
        print("playMp3")
    }

    func initView() -> Void {
        self.backgroundColor = UIColor.white
        let btnClose:UIButton = UIButton.initWith(imageNormal: UIImage.init(named: "home_close")!, radius: 0) { (btn) in
            if self.convertToMp3CloseClosure != nil {
                self.convertToMp3CloseClosure!("no", "")
            }
        }
        self.addSubview(btnClose)
        btnClose.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15)
            make.size.equalTo(CGSize(width:15, height:15))
        }

//        播放MP3录音
        let btnSound:UIButton = UIButton.initWith(imageNormal: UIImage.init(named: "default")!, radius: 0) { (btn) in
            self.playMp3();
        }
        self.addSubview(btnSound)
        btnSound.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(45)
            make.centerX.equalTo(self)
            make.size.equalTo(CGSize(width:92, height:92))
        }

        let lblTimer:UILabel = UILabel.initWith(title: String(timerInt), font: 15, color: COLOR_TEXT_TITLE)
        self.addSubview(lblTimer)
        lblTimer.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(153.5)
            make.centerX.equalTo(self)
            make.size.equalTo(CGSize(width:200, height:21))
        }
        lblTimer.textAlignment = NSTextAlignment.center
        lblTimer.tag = 1000

        let lblInfo:UILabel = UILabel.initWith(title: "正在录音，请描述停车信息", font: 15, color: COLOR_TEXT_TITLE)
        self.addSubview(lblInfo)
        lblInfo.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(183.5)
            make.centerX.equalTo(self)
            make.size.equalTo(CGSize(width:200, height:21))
        }

        let btnOver:UIButton = UIButton.initWithEvent(title: "说完了", font: 18, color: COLOR(string: "108EE9"), bgcolor: UIColor.white, radius: 0) { (btn) in
            btn.isUserInteractionEnabled = false
            self.stopRecord();
            self.convertToMP3();
            api_uploadUploadSound(soundStr: self.mp3Path!, SuccessClosure: { (model) in
                echo(data: "成功")
                if self.convertToMp3CloseClosure != nil {
                    self.convertToMp3CloseClosure!(self.mp3Path!, model.cloud_key!)
                }
            }) { (error) in
                echo(data: "失败")
                if self.convertToMp3CloseClosure != nil {
                    self.convertToMp3CloseClosure!("no", "")
                }
            }
        }

        self.addSubview(btnOver)
        btnOver.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(226);
            make.left.right.equalTo(self)
            make.height.equalTo(45)
        }
    }

    @objc func timerClick(sender:Any?) -> Void {
        timerInt = timerInt + 1;
        let lblTimer:UILabel = self.viewWithTag(1000) as! UILabel
        lblTimer.text = String(timerInt)
    }
}
