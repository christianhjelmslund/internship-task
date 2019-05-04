//
//  EventCell.swift
//  PwC task
//
//  Created by Christian Hjelmslund on 04/05/2019.
//  Copyright © 2019 Christian Hjelmslund. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var _description: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var attendees: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        bgView.setCornerRadiusAndShadow()
        bgView.backgroundColor = .dark
        name.textColor = .PwC_Orange
        date.textColor = .PwC_DarkOrange
        _description.textColor = .PwC_DarkOrange
        attendees.textColor = .PwC_DarkYellow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
