//
//  CustomVC.swift
//  SideMenu
//
//  Created by Truong Son Nguyen on 9/15/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

import UIKit



class SideMenuCustomVC: UIViewController {
 
    @IBOutlet weak var sideMenuContraint:NSLayoutConstraint!
    
    var sideMenuOpen = false
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toggleSideMenu),
                                               name: NSNotification.Name("ToggleSideMenu"),
                                               object: nil)
    }
    @objc func toggleSideMenu(){
        if sideMenuOpen {
            sideMenuOpen = false
            sideMenuContraint.constant = -213
        } else {
            sideMenuOpen = true
            sideMenuContraint.constant = 0
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    

    
}
