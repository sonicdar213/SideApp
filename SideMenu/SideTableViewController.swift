//
//  SideTableViewController.swift
//  SideMenu
//
//  Created by Truong Son Nguyen on 9/22/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

import UIKit

class SideTableViewController: UIViewController {
var img = ["a","b"]
var titlelabel = ["Profile","Setting","Account"]
    @IBOutlet var imgaccount: UIImageView!
    
    

}
extension SideTableViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlelabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideCell
        cell.titlelbl.text = titlelabel[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        switch indexPath.row {
        case 0:
            print("toLogin")
            NotificationCenter.default.post(name: NSNotification.Name("ToProfile"), object: nil)
        case 1:
            print("toSettings")
            NotificationCenter.default.post(name: NSNotification.Name("toSetting"), object: nil)
        case 2:
            print("toAccount")
            NotificationCenter.default.post(name: NSNotification.Name("toAccount"), object: nil)
        default:
            break
        }
    }

    
}
