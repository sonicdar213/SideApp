//
//  MainViewController.swift
//  SideMenu
//
//  Created by Truong Son Nguyen on 9/23/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import FirebaseAuth
import GoogleSignIn
class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(toProfile), name: NSNotification.Name("ToProfile"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toSetting), name: NSNotification.Name("toSetting"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toLougout), name: NSNotification.Name("toAccount"), object: nil)
        
    }
    @IBAction func btnpressed(_ sender: Any) {
        print("Toggle side menu")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    @objc func toProfile(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "toProfile", sender: nil)
        }
//        performSegue(withIdentifier: "toProfile", sender: nil)
    }
    @objc func toSetting(){
        performSegue(withIdentifier: "toSetting", sender: nil)
    }
    
    @objc func toLougout(){
        performSegue(withIdentifier: "toAccount", sender: nil)
    }
        
    @IBAction func LogoutBtn(_ sender: Any) {
        let keychainresult = KeychainWrapper.standard.removeObject(forKey: Key_UID)
        GIDSignIn.sharedInstance().signOut()
        print("\(keychainresult)")
        try! Auth.auth().signOut()
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginandregister")
        self.present(vc, animated: true, completion: nil)
        
    }
    
}
