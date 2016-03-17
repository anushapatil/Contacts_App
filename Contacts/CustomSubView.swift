//
//  CustomSubView.swift
//  Contacts
//
//  Created by Anusha Patil on 16/03/2016.
//  Copyright © 2016 Anusha Patil. All rights reserved.
//

import UIKit

protocol CustomSubViewDelegate
{
    
}

class CustomSubView: UIView,UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet weak var allContactsView: UIView!
    
    @IBOutlet weak var displayContactsView: UIView!
    @IBOutlet weak var groupsView: UIView?
    //MARK: Images view outlets
    @IBOutlet weak var dropdownImageView: UIImageView!
    
    //Table view outlets
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var allCallsTableView: UITableView!
    
    //MARK: Search bar outlets
    @IBOutlet weak var searchContactButton: UISearchBar!
    
    //MARK: Buttons outlets
    @IBOutlet weak var contactsToDisplayButton: UIButton!
    @IBOutlet weak var overFlowIcon: UIButton!

    var delegate:CustomSubViewDelegate!
    var displayingContacts:NSMutableArray = NSMutableArray();
    var alphabeticSortingDict:NSMutableDictionary?
    var alphabeticArray:NSMutableArray?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }

    override func drawRect(rect: CGRect)
    {
        
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        // Initialization code
        
        intialization();
    }
    
    func intialization()
    {
        self.contactsTableView!.registerNib(UINib(nibName:"ContactsCell", bundle: nil), forCellReuseIdentifier: "cell");

        self.sendSubviewToBack(dropdownImageView!);
        self.bringSubviewToFront(contactsToDisplayButton!);
    }
    
    func reloadTableData()
    {
        //self.contactsTableView.reloadData();
    }
    
    //MARK: Table view delegate and datasource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return alphabeticSortingDict!.count+1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return 1;
        }
        
        let string = alphabeticArray!.objectAtIndex(section-1);
        //Get the section elements
        displayingContacts = alphabeticSortingDict!.valueForKey(string as! String) as! NSMutableArray
        return displayingContacts.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = self.contactsTableView!.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ContactsCell
        cell.translatesAutoresizingMaskIntoConstraints = true;
        if indexPath.row == 0 && indexPath.section == 0
        {
            cell.contactsNameLabel.text = "SET UP MY PROFILE";
            cell.contactsImageView.image = UIImage (named: "person.png");
            
            return cell;
        }
        
        let string = alphabeticArray!.objectAtIndex(indexPath.section-1);
        
        //Get the section elements
        displayingContacts = alphabeticSortingDict!.valueForKey(string as! String) as! NSMutableArray
        let contacts =  displayingContacts[indexPath.row] as! Contacts;
        cell.contactsNameLabel.text = contacts.firstName;
        cell.contactsImageView.image = UIImage (named: "person.png");
        return cell;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let v = UIView();
        let label = UILabel();
        var text = "";
        
        if section == 0
        {
            text = "ME";
        }
        else
        {
            let string:String = alphabeticArray!.objectAtIndex(section-1) as! String;
            let stringArray = string.componentsSeparatedByString("\"");
            text = stringArray[1].uppercaseString;
        }
        
        label.text = text;
        let size = label.font.sizeOfString(text, containedWidth: 20.0);
        label.frame = CGRectMake(CGRectGetMinX(v.frame), CGRectGetMinY(v.frame), size.width, size.height);
        label.backgroundColor = UIColor.clearColor();
        v.addSubview(label);
        
        let label1 = UILabel();
        label1.backgroundColor = UIColor.blackColor();
        label1.frame = CGRectMake(CGRectGetWidth(label.frame), CGRectGetHeight(label.frame)-2.0, CGRectGetWidth(tableView.frame)-CGRectGetWidth(label.frame), 0.5);
        v.addSubview(label1);
        
        v.backgroundColor = UIColor.clearColor();
        return v;
    }
    
    //MARK: ACTION METHODS
    
    @IBAction func didClickOnOverFlowButton(sender: AnyObject)
    {
        
    }
    
    @IBAction func didClickOnDisplayContactsButton(sender: AnyObject)
    {
        
    }

}
