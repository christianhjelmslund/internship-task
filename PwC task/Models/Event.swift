//
//  Event.swift
//  PwC task
//
//  Created by Christian Hjelmslund on 03/05/2019.
//  Copyright © 2019 Christian Hjelmslund. All rights reserved.
//

import UIKit

struct Event {
    var id: String
    var name: String
    var _description: String
    var date: Date
    var attendees: [Attendee]?
}
