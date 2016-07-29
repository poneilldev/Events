//
//  Event.swift
//  Zanga_0.2
//
//  Created by Paul O'Neill on 7/25/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import Foundation

class Event {
    var event_id : String?
    var title: String?
    var location: String?
    var description: String?
    var pic_loc: String?
    var event_type: String?
    var creatorUserId: String?
    var startTime: String?
    var endTime: String?
    var school: String?
    var eventDate: String?

    
    // MARK: - Initializers
    
    init() {
        event_id = ""
        title = ""
        location = ""
        description = ""
        pic_loc = ""
        event_type = ""
        creatorUserId = ""
        startTime = ""
        endTime = ""
        school = ""
        eventDate = ""
    }
    
    init(event_id: String, title: String, location: String, description: String,
         pic_loc: String, event_type: String, creatorUserId: String, startTime: String,
         endTime: String, school: String, eventDate: String) {
        self.event_id = event_id
        self.title = title
        self.location = location
        self.description = description
        self.pic_loc = pic_loc
        self.event_type = event_type
        self.creatorUserId = creatorUserId
        self.startTime = startTime
        self.endTime = endTime
        self.school = school
        self.eventDate = eventDate
    }
    
    // MARK: - Methods
    
}