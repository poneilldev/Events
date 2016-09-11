//
//  CreatePrivateTableViewController.swift
//  Zanga_0.2
//
//  Created by Paul O'Neill on 9/10/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import UIKit

class CreatePrivateTableViewController: UITableViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleTableViewCell: UITableViewCell!
    @IBOutlet weak var dateTableViewCell: UITableViewCell!
    @IBOutlet weak var locationTableViewCell: UITableViewCell!
    @IBOutlet weak var descriptionTableViewCell: UITableViewCell!
    @IBOutlet weak var addPhotoTableViewCell: UITableViewCell!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var eventPhotoView: UIImageView!
    
    var datePickerVisible = false
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.hidden = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        self.tabBarController?.tabBar.barTintColor = UIColor.backGroundBlack()
        self.tabBarController?.tabBar.tintColor = UIColor.myRed()
        self.navigationController?.navigationBar.translucent = false
        self.view.backgroundColor = UIColor.blackColor()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d @ h:mm a"
        dateLabel.text = dateFormatter.stringFromDate(datePicker.date)
        
        self.dateLabel.userInteractionEnabled = true
        self.dateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CreatePrivateTableViewController.dateLabelIsTapped)))
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CreatePrivateTableViewController.viewIsTapped)))
        self.datePicker.addTarget(self, action: #selector(CreatePrivateTableViewController.datePickerValueChanged), forControlEvents: .ValueChanged)
        self.dateLabel.textColor = UIColor.whiteColor()
        
        self.titleTableViewCell.contentView.backgroundColor = UIColor.backGroundBlack()
        self.dateTableViewCell.contentView.backgroundColor = UIColor.backGroundBlack()
        self.locationTableViewCell.contentView.backgroundColor = UIColor.backGroundBlack()
        self.descriptionTableViewCell.contentView.backgroundColor = UIColor.backGroundBlack()
        
        self.titleTextField.backgroundColor = UIColor.backGroundBlack()
        self.locationTextField.backgroundColor = UIColor.backGroundBlack()
        self.descriptionTextView.backgroundColor = UIColor.backGroundBlack()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.backgroundColor = UIColor.backGroundBlack()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.myRed()]
        
        descriptionTextView.delegate = self
        descriptionTextView.text = "Description"
        descriptionTextView.textColor = UIColor.lightGrayColor()
        descriptionTextView.selectedTextRange = descriptionTextView.textRangeFromPosition(descriptionTextView.beginningOfDocument, toPosition: descriptionTextView.beginningOfDocument)
        
        imagePicker.delegate = self
        addPhotoTableViewCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CreatePrivateTableViewController.loadImagePressed)))
        
    }

    
    func datePickerValueChanged() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d @ h:mm a"
        dateLabel.text = dateFormatter.stringFromDate(datePicker.date)
    }
    
    func loadImagePressed() {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let takePictionAction = UIAlertAction(title: "Take Photo", style: .Default) { (alert: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = .Camera
                self.presentViewController(self.imagePicker, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "No camera available", preferredStyle: .Alert)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        let photoFromLibraryAction = UIAlertAction(title: "Photo Library", style: .Default) { (alert: UIAlertAction) in
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (alert: UIAlertAction) in
        }
        
        optionMenu.addAction(takePictionAction)
        optionMenu.addAction(photoFromLibraryAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }

    
    @IBAction func cancelPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func createEvent(sender: AnyObject) {
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.eventPhotoView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func viewIsTapped() {
        self.view.endEditing(true)
    }
    
    func dateLabelIsTapped() {
        
        if datePickerVisible {
            self.hideDatePickerCell()
        } else {
            self.showDatePickerCell()
        }
        
        self.view.endEditing(true)
    }
    
    
    func showDatePickerCell() {
        self.datePickerVisible = true
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        self.datePicker.hidden = false
        self.datePicker.alpha = 0.0
        UIView.animateWithDuration(0.25) {
            self.datePicker.alpha = 1.0
        }
    }
    
    func hideDatePickerCell() {
        self.datePickerVisible = false
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        UIView.animateWithDuration(0.25, animations: {
            self.datePicker.alpha = 0.0
        }) { (finished) in
            self.datePicker.hidden = true
        }
    }
    

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 2
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height = self.tableView.rowHeight
        if indexPath.row == 0 && indexPath.section == 1 {
            height = self.datePickerVisible ? 216.0 : 40.0
        }
        
        if indexPath.row == 1 && indexPath.section == 2 {
            height = 130
        }
        
        return height
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 && indexPath.section == 1{
            if datePickerVisible {
                self.hideDatePickerCell()
            } else {
                self.showDatePickerCell()
            }
        }
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView
    {
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 20))
        
        headerView.backgroundColor = UIColor.blackColor()
        
        return headerView
    }
    
    //MARK: Placeholder code
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:NSString = textView.text
        let updatedText = currentText.stringByReplacingCharactersInRange(range, withString:text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = "Description"
            textView.textColor = UIColor.lightGrayColor()
            
            textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            
            return false
        }
            
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, clear
            // the text view and set its color to black to prepare for
            // the user's entry
        else if textView.textColor == UIColor.lightGrayColor() && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.whiteColor()
        }
        
        return true
    }
    
    func textViewDidChangeSelection(textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGrayColor() {
                textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            }
        }
    }


   
}
