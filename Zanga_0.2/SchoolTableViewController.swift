//
//  SchoolTableViewController.swift
//  Zanga_0.2
//
//  Created by Paul O'Neill on 7/25/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import UIKit

enum School: String {
    case byui = "http://calendar.byui.edu/RSSFeeds.aspx?data=tq9cbc8b%2btuQeZGvCTEMSP%2bfv3SYIrjQ3VTAXA335bE0WtJCqYU4mp9MMtuSlz6MRZ4LbMUU%2fO4%3d"
    case byu = "byu"
    case uofu = "uofu"
    case uvu = "uvu"
}

class SchoolTableViewController: UITableViewController, NSXMLParserDelegate {
    
    var schoolEvents: [Event] = []
    var selectedEvent = Event()
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var eDate = NSString()
    var eImage = NSString()
    var eDisc = NSMutableString()
    var eLink = NSMutableString()
    var eCatagory = NSMutableString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        do {
            try beginParsing()
        } catch {
            fatalError("Parsing Failed")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Helper methods
    
    func beginParsing() throws {
        posts = []
        if let url: NSURL = NSURL(string: School.byui.rawValue) {
            if let xmlParser = NSXMLParser(contentsOfURL: url) {
                parser = xmlParser
                parser.delegate = self
                parser.parse()
                tableView!.reloadData()
            }
        }
    }
    
    func convertTime(time: String) -> String {
        var convertedTime : String = ""
        let dateString = time
        // cut out time zone code (GMT)
        let newStringDate = dateString.substringWithRange(Range<String.Index>(dateString.startIndex...dateString.startIndex.advancedBy(24)))
        let formatter = NSDateFormatter();
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        if let dateFromString = formatter.dateFromString(newStringDate) {
            formatter.dateFormat = "EEE, dd MMM hh:mm a"
            formatter.timeZone = NSTimeZone.localTimeZone()
            //date.setString(formatter.stringFromDate(dateFromString))
            convertedTime = formatter.stringFromDate(dateFromString) as String
        }
        
        return convertedTime
    }
    
    // MARK: - Parser Methods
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName
        if (elementName as NSString).isEqualToString("item") {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            eDate = NSString()
            eDate = ""
            eImage = NSString()
            eImage = ""
            eDisc = NSMutableString()
            eDisc = ""
            eLink = NSMutableString()
            eLink = ""
            
        }
        else if (elementName as NSString).isEqualToString("enclosure") {
            let imgLink = attributeDict["url"]! as String
            eImage = imgLink
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqualToString("item") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "title")
            }
            
            if !eDate.isEqual(nil) {
                elements.setObject(convertTime(eDate as String), forKey: "pubDate")
            }
            
            if !eImage.isEqual(nil) {
                elements.setObject(eImage, forKey: "enclosure")
            }
            
            if !eDisc.isEqualToString("") {
                elements.setObject(eDisc, forKey: "description")
            }
            
            if !eLink.isEqual(nil) {
                elements.setObject(eLink, forKey: "link")
            }
            
            if !eCatagory.isEqual(nil) {
                elements.setObject(eCatagory, forKey: "catagory")
            }
            
            posts.addObject(elements)
            
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if element == "title" {
            title1.appendString(string)
        } else if element == "pubDate" {
            eDate = string
        } else if element == "description" {
            eDisc.appendString(string)
        } else if element == "link" {
            eLink.appendString(string)
        } else if element == "catagory" {
            eCatagory.appendString(string)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! SchoolEvent_StoryBoardTableViewCell
        
        if let day = posts.objectAtIndex(indexPath.row).valueForKey("pubDate") as? String{
            let dayOfWeek = day.substringWithRange(Range<String.Index>(day.startIndex..<day.startIndex.advancedBy(3)))
            let date = day.substringWithRange(Range<String.Index>(day.startIndex.advancedBy(5)...day.startIndex.advancedBy(11)))
            //let timeOfDay = day.substringWithRange(Range<String.Index>(day.startIndex.advancedBy(12)...day.endIndex))
            let url = posts.objectAtIndex(indexPath.row).valueForKey("enclosure") as? String
            let eventTitle = posts.objectAtIndex(indexPath.row).valueForKey("title") as? String
            
            cell.setCellItems(eventTitle!, date: date, day: dayOfWeek, imgURL: url!)
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let post : NSMutableDictionary = (self.posts[indexPath.row] as? NSMutableDictionary)!
        selectedEvent.title = post.valueForKey("title") as? String
        selectedEvent.eventDate = post.valueForKey("pubDate") as? String
        selectedEvent.description = post.valueForKey("description") as? String
        selectedEvent.eventImage = post.valueForKey("enclosure") as? String
        selectedEvent.location = "BYUI Campus"
        self.performSegueWithIdentifier("eventDetailSegue", sender: self)
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //self.tableview.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        let detailViewController = segue.destinationViewController as! EventInfoViewController
        detailViewController.selectedEvent = self.selectedEvent
        // Pass the selected object to the new view controller.
    }
    
}
