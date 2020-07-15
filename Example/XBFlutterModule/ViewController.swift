//
//  ViewController.swift
//  XBFlutterModule
//
//  Created by henrylee_2020 on 06/19/2020.
//  Copyright (c) 2020 henrylee_2020. All rights reserved.
//

import UIKit
import Flutter
import flutter_boost

class ViewController: UIViewController, FlutterStreamHandler {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(type:UIButton.ButtonType.custom)
        button.setTitle("Flutter HomePage", for: .normal)
        button.backgroundColor = .red
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.addTarget(self, action: #selector(handleButtonAction), for: .touchUpInside)
        view.addSubview(button)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleButtonAction() {
//        FlutterBoostPlugin.open("first", urlParams: ["hello":"world", kPageCallBackId: "firstPage"], exts: ["animated": true], onPageFinished: { (map) in
//                   print(map)
//               }) { (finishde) in
//               print("\(finishde)")
//        }
        guard let flutterEngine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine else { return };
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)

        let channel = FlutterMethodChannel.init(name: "https://www.xiaoyukeji.cn", binaryMessenger: flutterViewController as! FlutterBinaryMessenger)
        channel.setMethodCallHandler { [weak self](call, result) in
            guard let `self` = self else {return}
            if call.method == "callNativeMethond" {
                let para = call.arguments
                print(para!)

                result("原生返回数据")
            }else if call.method == "pushNewPage" {
//                let newfluController = FlutterViewController()

                guard let flutterEngine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine else { return };
                let newfluController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
                self.navigationController?.pushViewController(newfluController, animated: true)
            }else{
                result(FlutterMethodNotImplemented)
            }
        }
        let eventChannel = FlutterEventChannel.init(name: "https://www.xiaoyukeji1.cn", binaryMessenger: flutterViewController as! FlutterBinaryMessenger)
        eventChannel.setStreamHandler(self)
        self.navigationController?.pushViewController(flutterViewController, animated: true)
    }
    
    /// 这个onListen是Flutter端开始监听这个channel时的回调，第二个参数 EventSink是用来传数据的载体。
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        // arguments flutter给native的参数
        // 回调给flutter， 建议使用实例指向，因为该block可以使用多次
        events("push传值给flutter的vc");
        return nil;
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        // arguments flutter给native的参数
        print(arguments ?? "空参数")
        return nil;
    }
    
}

