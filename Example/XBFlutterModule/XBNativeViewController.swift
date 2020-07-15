//
//  XBNativeViewController.swift
//  XBFlutterModule_Example
//
//  Created by lihaiyang on 2020/7/13.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import flutter_boost

class XBNativeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "这是原生页面"
        let button = UIButton(type:UIButton.ButtonType.custom)
        button.setTitle("", for: .normal)
        button.backgroundColor = .red
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.addTarget(self, action: #selector(handleButtonAction), for: .touchUpInside)
        view.addSubview(button)
        view.backgroundColor = .yellow
        // Do any additional setup after loading the view.
    }
    
    @objc func handleButtonAction() {
//        FlutterBoostPlugin.open("flutterPage", urlParams: ["hello":"world", kPageCallBackId: "flutterPage"], exts: ["animated": true], onPageFinished: { (map) in
//            print(map)
//        }) { (finishde) in
//            print("\(finishde)")
//        }
                guard let flutterEngine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine else { return };
                let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
                self.navigationController?.pushViewController(flutterViewController, animated: true)
    }

}
