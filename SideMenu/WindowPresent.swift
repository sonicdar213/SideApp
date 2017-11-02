//
//  WindowPresent.swift
//  SideMenu
//
//  Created by Truong Son Nguyen on 10/31/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

import UIKit

class WindowPresent: UIViewController {

    static var windowStack = Array<UIWindow>()
    private var myWindow:UIWindow?
    var animateDuration = 0.25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    open func presentWindowView(complete: (()->Void)? = nil) {
        DispatchQueue.main.async {
            WindowPresent.windowStack.append(UIApplication.shared.keyWindow!)
            self.myWindow = UIWindow.init(frame: UIScreen.main.bounds)
            
            self.myWindow?.windowLevel = UIWindowLevelAlert
            self.myWindow?.rootViewController = self;
            self.view.alpha = 0.0
            
            self.myWindow?.makeKeyAndVisible()
            UIView.animate(withDuration: self.animateDuration, animations: {
                self.view.alpha = 1.0
            }, completion: {completion in
                if complete != nil {
                    complete!()
                }
            })
        }
    }
    
    open func dismissWindowView(complete: (()->Void)? = nil) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: self.animateDuration, animations: {
                self.view.alpha = 0.0
            }, completion: { completion in
                DispatchQueue.main.async {
                    //If window is visible, then hide it. If not, simply remove it
                    if let index = WindowPresent.windowStack.index(of: self.myWindow!) {
                        WindowPresent.windowStack.remove(at: index)
                    }
                    else {
                        let previousWindow = WindowPresent.windowStack.removeLast()
                        self.myWindow?.isHidden = true
                        previousWindow.makeKeyAndVisible()
                    }
                    //Release all my object
                    self.myWindow = nil
                    
                    if complete != nil {
                        complete!()
                    }
                }
            })
        }
    }

}
