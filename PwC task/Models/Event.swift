//
//  Event.swift
//  PwC task
//
//  Created by Christian Hjelmslund on 03/05/2019.
//  Copyright © 2019 Christian Hjelmslund. All rights reserved.
//

import UIKit

class Event: NSObject {
    var name: String
    var _description: String
    var date: Date
    var attendees: [Attendee]
    
    init(name: String, description: String, date: Date, attendees: [Attendee]) {
        self.name = name
        self._description = description
        self.date = date
        self.attendees = attendees
    }
}
