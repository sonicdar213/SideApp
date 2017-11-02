//
//  SideCell.swift
//  SideMenu
//
//  Created by Truong Son Nguyen on 11/1/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

import UIKit

class SideCell: UITableViewCell {

    @IBOutlet var titlelbl: UILabel!
    @IBOutlet var imgcell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell() {
        
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
