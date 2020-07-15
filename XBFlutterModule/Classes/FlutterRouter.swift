//
//  safsd.swift
//  XBFlutterModule_Example
//
//  Created by lihaiyang on 2020/7/13.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import flutter_boost

class FlutterRouter : NSObject, FLBPlatform{
    //里面实现FLBPlatform协议的方法，具体代码可以参考官方demo自行修改
    func open(_ url: String, urlParams: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
        var animated = false;
        if exts["animated"] != nil{
            animated = exts["animated"] as! Bool;
        }
        var vc: UIViewController?
        if url == "XBNativeViewController" {
            vc = XBNativeViewController()
        } else {
            vc = FLBFlutterViewContainer.init();
            (vc as! FLBFlutterViewContainer).setName(url, params: urlParams);
        }
        guard let vc1 = vc else {
            return
        }
        self.navigationController().pushViewController(vc1, animated: animated);
        completion(true);
    }

    func present(_ url: String, urlParams: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
        var animated = false;
        if exts["animated"] != nil{
            animated = exts["animated"] as! Bool;
        }
        let vc = FLBFlutterViewContainer.init();
        vc.setName(url, params: urlParams);
        navigationController().present(vc, animated: animated) {
            completion(true);
        };
    }
    
    func close(_ uid: String, result: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
        var animated = false;
        if exts["animated"] != nil{
            animated = exts["animated"] as! Bool;
        }
        let presentedVC = self.navigationController().presentedViewController;
        let vc = presentedVC as? FLBFlutterViewContainer;
        if vc?.uniqueIDString() == uid {
            vc?.dismiss(animated: animated, completion: {
                completion(true);
            });
        }else{
            self.navigationController().popViewController(animated: animated);
        }
    }
    
    func navigationController() -> UINavigationController {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let navigationController = delegate.window?.rootViewController as! UINavigationController
        return navigationController;
    }
}
