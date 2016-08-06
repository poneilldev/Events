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
    
    var passedEvent = Event()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        eventTitle.textColor = UIColor.whiteColor()
        eventDate.textColor = UIColor.lightGrayColor()
        eventTime.textColor = UIColor.lightGrayColor()
        eventLocation.textColor = UIColor.lightGrayColor()
        eventHost.textColor = UIColor.lightGrayColor()
        eventDescription.textColor = UIColor.lightGrayColor()
        
        
        eventTitle.text = passedEvent.title
        eventImage.sd_setImageWithURL(NSURL(string: passedEvent.eventImage!), placeholderImage: AppImages.PlaceHolder.image())
        eventDate.text = passedEvent.eventDate
        
        // User cannot add event without inputing start time
        if passedEvent.startTime == "" && passedEvent.endTime == "" {
            eventTime.text = "N/A"
        } else if passedEvent.startTime != "" && passedEvent.endTime == "" {
            eventTime.text = "\(passedEvent.startTime)"
        }
        else if passedEvent.startTime != "" && passedEvent.endTime != "" {
            eventTime.text = "\(passedEvent.startTime) - \(passedEvent.endTime)"
        }
        
        eventLocation.text = passedEvent.location
        eventHost.text = "Host"
        eventDescription.text = passedEvent.description
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func imGoing(sender: UIButton) {
        print("I'M GOING!")
    }
    

}
