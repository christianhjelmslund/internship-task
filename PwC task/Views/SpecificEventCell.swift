//
//  SpecificEventCellTableViewCell.swift
//  PwC task
//
//  Created by Christian Hjelmslund on 04/05/2019.
//  Copyright © 2019 Christian Hjelmslund. All rights reserved.
//

import UIKit

class SpecificEventCell: UITableViewCell {

    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        phone.textColor = .white
        email.textColor = .white
        name.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
