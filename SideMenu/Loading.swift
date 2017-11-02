//
//  ViewController.swift
//  SideMenu
//
//  Created by Truong Son Nguyen on 9/15/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Reachability
class Loading: UIViewController {
    let reachability = Reachability()!

    var menuVC: LoginViewController?
    var internetVC : NetworkConditionVC?
    
    @IBOutlet weak var imgloading: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.internetLoading()
        self.enableInternetCheck()
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityDidChange), name: NSNotification.Name.reachabilityChanged, object: nil)
    }

    //MARK: - INTERNET CONNECTION
    func enableInternetCheck() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    @objc func reachabilityDidChange(notif: Notification) {
        if let reachability = notif.object as? Reachability {
            if reachability.connection != .none {
                print("Reachable")
                if let _vc = internetVC {
                    _vc.dismissWindowView()
                    internetVC = nil
                    }
               
                }
            else {
                print("NotReachable")
                if internetVC == nil {
                    internetVC = NetworkConditionVC()
                    internetVC!.presentWindowView()
                }
            }
        }
    }
    func internetLoading() {
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            self.performSegue(withIdentifier: "toLoginMenu", sender: nil)
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

   

    }

