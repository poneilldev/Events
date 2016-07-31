//
//  EventInfoViewController.swift
//  Zanga_0.2
//
//  Created by Paul O'Neill on 7/30/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import UIKit

class EventInfoViewController: UIViewController {

    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventHost: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    
    var selectedEvent = Event()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTitle.text = selectedEvent.title
        if let imgURL = selectedEvent.eventImage {
            eventImage.sd_setImageWithURL(NSURL(string: imgURL), placeholderImage: UIImage(named: "placeholder.jpg"))
        }
        eventDate.text = selectedEvent.eventDate
        // User cannot add event without inputing start time
        if selectedEvent.endTime != nil || selectedEvent.endTime != "" {
            eventTime.text = "\(selectedEvent.startTime) - \(selectedEvent.endTime)"
        }
        eventLocation.text = selectedEvent.location
        eventHost.text = "Host"
        eventDescription.text = selectedEvent.description
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func imGoing(sender: UIButton) {
    }


    
    @IBAction func inviteOtherFriends(sender: AnyObject) {
    }
    
    

}
