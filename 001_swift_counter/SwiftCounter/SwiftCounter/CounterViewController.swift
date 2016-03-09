//
//  CounterViewController.swift
//  SwiftCounter
//
//  Created by Jason Li on 6/17/14.
//  Copyright (c) 2014 Swiftist. All rights reserved.
//

import UIKit

// 随机色
func randomColor() -> UIColor {
    return UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
}

class ViewController: UIViewController {
    // 声明子控件
    var timeLabel: UILabel?
    var timeButtons: [UIButton]?
    var startStopButton: UIButton?
    var clearButton: UIButton?
    var timer: NSTimer?
    // 按钮信息
    let timeButtonInfos = [("1分", 60), ("3分", 180), ("5分", 300), ("1秒", 1)]
    // 当前倒计时剩余的秒数
    var remainingSeconds: Int = 0 {
        // 添加一个willSet属性 - 重写set方法
        willSet(newSeconds) {
            buttonStates(startStopButton!, enabled: (newSeconds > 0))
            let mins = newSeconds / 60
            let seconds = newSeconds % 60
            self.timeLabel!.text = NSString(format: "%02d : %02d", mins, seconds) as String
        }
    }
    
    var isCounting: Bool = false {
        willSet(newValue) {
            if newValue { // ture 定时器开启
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
                // 注册一个本地通知
                createAndFireLocalNotificationAfterSeconds(remainingSeconds)
            } else {
                // 停止计时并清空定时器
                timer?.invalidate()
                timer = nil
            }
            
            // 判断按钮的状态, 来修改按钮的显示
            buttonStates(clearButton!, enabled: !newValue)
            for button in timeButtons! {
                buttonStates(button, enabled: !newValue)
            }
            
            if remainingSeconds <= 0 {
                startStopButton!.selected = newValue
                buttonStates(startStopButton!, enabled: newValue)
            }
        }
    }
    
    func buttonStates(button: UIButton ,enabled: Bool) {
        button.enabled = enabled
        button.alpha = enabled ? 1.0 : 0.3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTimeLabel()
        self.setupTimeButtons()
        self.setupActionButtons()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let viewW = self.view.bounds.size.width
        let viewH = self.view.bounds.size.height
        
        // 时间显示
        let margin: CGFloat = 10
        let timeLabelW: CGFloat = 40
        let timeLabelH: CGFloat = 120
        timeLabel!.frame = CGRectMake(margin, timeLabelW, viewW - margin * 2, timeLabelH)
        
        // 时间按钮
        let timeButtonW: CGFloat = (viewW - margin * CGFloat(timeButtons!.count + 1)) / CGFloat(timeButtons!.count)
        let timeButtonH: CGFloat = 44
        let timeButtonY: CGFloat = viewH - 120
        for (index, button) in timeButtons!.enumerate() {
            let timeButtonX = (timeButtonW + margin) * CGFloat(index) + margin
            button.frame = CGRectMake(timeButtonX, timeButtonY, timeButtonW, timeButtonH)
        }
        
        startStopButton!.frame = CGRectMake(margin, CGRectGetMaxY(timeButtons![0].frame) + margin, viewW * 0.7 - margin * 2, timeButtonH)
        
        clearButton!.frame = CGRectMake(CGRectGetMaxX(startStopButton!.frame) + margin, startStopButton!.frame.origin.y, viewW - CGRectGetMaxX(startStopButton!.frame) - margin * 2, timeButtonH)
    }
    
    // 初始化时间label
    func setupTimeLabel() {
        timeLabel = UILabel()
        timeLabel!.textColor = UIColor.whiteColor()
        timeLabel!.font = UIFont.systemFontOfSize(80)
        timeLabel!.backgroundColor = UIColor.blackColor()
        timeLabel!.textAlignment = NSTextAlignment.Center
        timeLabel!.text = "00 : 00"
        
        self.view.addSubview(timeLabel!)
    }
    
    // 初始化按钮
    func setupTimeButtons() {
        // 创建一个button数组
        var buttons: [UIButton] = []
        for(index, (title, _)) in timeButtonInfos.enumerate() {
            // 实例化一个button
            let button: UIButton = UIButton()
            // 获取button的tag
            button.tag = index
            button.setTitle(title, forState: UIControlState.Normal)
            
            button.backgroundColor = randomColor()
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
            
            button.addTarget(self, action: "timeButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            
            // 将元素添加进数组
            buttons += [button]
            
            self.view.addSubview(button)
        }
        timeButtons = buttons
    }
    
    // 操作按钮
    func setupActionButtons() {
        startStopButton = UIButton()
        buttonStates(startStopButton!, enabled: false)
        startStopButton!.backgroundColor = UIColor.redColor()
        startStopButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        startStopButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Selected)
        startStopButton!.setTitle("启动/停止", forState: UIControlState.Normal)
        startStopButton!.addTarget(self, action: "startStopButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(startStopButton!)
        
        clearButton = UIButton()
        clearButton!.backgroundColor = UIColor.redColor()
        clearButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        clearButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        clearButton!.setTitle("复位", forState: UIControlState.Normal)
        clearButton!.addTarget(self, action: "clearButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(clearButton!)
    }
    
    // 按钮响应方法
    func timeButtonTapped(sender: UIButton) {
        // 根据按钮的tag取出元组中seconds值, _表示不用到数组的这个元素
        let (_, seconds) = timeButtonInfos[sender.tag]
        remainingSeconds += seconds;
        
        // 当点击时间的时候就开始就变成true
        buttonStates(startStopButton!, enabled: true)
    }
    
    func startStopButtonTapped(sender: UIButton) {
        sender.selected = !sender.selected
        // 开始计时
        self.isCounting = sender.selected
    }
    
    func clearButtonTapped(sender: UIButton) {
        
        if remainingSeconds > 0 {
            remainingSeconds = 0
        }
    }
    
    func updateTimer() {
        remainingSeconds -= 1
        if remainingSeconds <= 0 {
            let alert = UIAlertController(title: "计时完成", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "知道了", style: UIAlertActionStyle.Default, handler:nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
            isCounting = false
        }
    }
    
    // 创建一个本地通知
    func createAndFireLocalNotificationAfterSeconds(seconds: Int) {
        // 取消当前app在本地注册的消息
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        let notification = UILocalNotification()
        let timeIntervalSinceNow = NSTimeInterval(seconds)
        
        // 消息激活时间(开始计时的时间)
        notification.fireDate = NSDate(timeIntervalSinceNow: timeIntervalSinceNow)
        // 设置时区
        notification.timeZone = NSTimeZone.systemTimeZone()
        
        notification.alertBody = "计时完成"
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
}
