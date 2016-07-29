//
//  SchoolTableViewCell.swift
//  Zanga_0.2
//
//  Created by Paul O'Neill on 7/25/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDay: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        eventImage = nil
        eventDate.text = ""
        eventTitle.text = ""
        eventDay.text = ""
    }
    
    func setCellItems(title: String, date: String, day: String, imgURL: String) -> Void {
        eventTitle.text = title
        eventDate.text = date
        eventDay.text = day
        eventImage.sd_setImageWithURL(NSURL(string: imgURL ?? "empty"), placeholderImage: UIImage(named: "placeholder.jpg"))
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
