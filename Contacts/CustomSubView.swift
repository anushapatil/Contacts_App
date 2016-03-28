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
    func addDisplayViewController();
    func showAlert();
}

class CustomSubView: UIView,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate
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
    var filterdAlphabeticSortingDict:NSMutableDictionary = NSMutableDictionary()
    var filteredAlphabeticArray:NSMutableArray = NSMutableArray()
    var filteredDisplayingContacts:NSMutableArray = NSMutableArray();
    var storedContactsArray:NSMutableArray?
    var selectedContact:Contacts?
    var filteredArray = []
    
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
        
        self.allCallsTableView!.registerNib(UINib(nibName:"AllCallsCell", bundle: nil), forCellReuseIdentifier: "allCallsCell");
        
        self.sendSubviewToBack(dropdownImageView!);
        self.bringSubviewToFront(contactsToDisplayButton!);
    }
    
    func reloadTableData()
    {
        self.contactsTableView.reloadData();
        self.allCallsTableView.reloadData();
    }
    
    func getSelectedContact()->Contacts
    {
        return selectedContact!;
    }
    
    //MARK: Table view delegate and datasource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        if tableView == self.contactsTableView
        {
            if filterdAlphabeticSortingDict.count != 0
            {
                return filterdAlphabeticSortingDict.count;
            }
            return alphabeticSortingDict!.count+1;
        }
        else if tableView == self.allCallsTableView
        {
            if storedContactsArray?.count != 0
            {
                return 1;
            }
            return 0;
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == self.contactsTableView
        {
            if filterdAlphabeticSortingDict.count != 0
            {
                let string = filteredAlphabeticArray.objectAtIndex(section);
                //Get the section elements
                filteredDisplayingContacts = filterdAlphabeticSortingDict.valueForKey(string as! String) as! NSMutableArray
                return filteredDisplayingContacts.count;
            }
            
            if section == 0
            {
                return 1;
            }
            
            let string = alphabeticArray!.objectAtIndex(section-1);
            //Get the section elements
            displayingContacts = alphabeticSortingDict!.valueForKey(string as! String) as! NSMutableArray
            return displayingContacts.count;
        }
        else if tableView == self.allCallsTableView
        {
            return storedContactsArray!.count;
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:UITableViewCell?
        if tableView == self.contactsTableView
        {
            let contactsCell = self.contactsTableView!.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ContactsCell
            
            if filterdAlphabeticSortingDict.count != 0
            {
                let string = filteredAlphabeticArray.objectAtIndex(indexPath.section);
                
                //Get the section elements
                filteredDisplayingContacts = filterdAlphabeticSortingDict.valueForKey(string as! String) as! NSMutableArray
                let contacts =  filteredDisplayingContacts[indexPath.row] as! Contacts;
                contactsCell.contactsNameLabel.text = contacts.firstName;
            }
            else
            {
                if indexPath.row == 0 && indexPath.section == 0
                {
                    contactsCell.contactsNameLabel.text = "SET UP MY PROFILE"
                }
                else
                {
                    let string = alphabeticArray!.objectAtIndex(indexPath.section-1);
                    
                    //Get the section elements
                    displayingContacts = alphabeticSortingDict!.valueForKey(string as! String) as! NSMutableArray
                    let contacts =  displayingContacts[indexPath.row] as! Contacts;
                    contactsCell.contactsNameLabel.text = contacts.firstName;
                }
            }
            contactsCell.contactsImageView.image = UIImage (named: "person.png");
            cell = contactsCell;
        }
        else if tableView == self.allCallsTableView
        {
            let allContactsCell = self.allCallsTableView!.dequeueReusableCellWithIdentifier("allCallsCell", forIndexPath: indexPath) as! AllCallsCell

            let contacts =  storedContactsArray?.objectAtIndex(indexPath.row) as! Contacts;
            
            allContactsCell.contactsImageView.image = UIImage (named: "person.png");
            allContactsCell.contactNumberLabel.text = contacts.phone;
            allContactsCell.nameLabel.text = contacts.firstName;
            
            allContactsCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator;
            
            cell = allContactsCell;
        }
        
        return cell!;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if tableView == self.contactsTableView
        {
            var text = "";
            if filterdAlphabeticSortingDict.count != 0
            {
                let string = filteredAlphabeticArray.objectAtIndex(section) as! String;
                let stringArray = string.componentsSeparatedByString("\"");
                text = stringArray[1].uppercaseString;
            }
            else
            {
                if section == 0
                {
                    text = "ME";
                }
                else
                {
                    let string = alphabeticArray!.objectAtIndex(section-1) as! String;
                    let stringArray = string.componentsSeparatedByString("\"");
                    text = stringArray[1].uppercaseString;
                }
            }
            
            
            let v = UIView();
            let label = UILabel();
            
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
        return nil;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if tableView == self.contactsTableView
        {
            if indexPath.section == 0 && indexPath.row == 0
            {
                return;
            }
            let string = alphabeticArray!.objectAtIndex(indexPath.section-1);
            displayingContacts = alphabeticSortingDict!.valueForKey(string as! String) as! NSMutableArray
            selectedContact =  displayingContacts[indexPath.row] as? Contacts;
            self.delegate.addDisplayViewController();
        }
    }

    //MARK: ACTION METHODS
    
    @IBAction func didClickOnOverFlowButton(sender: AnyObject)
    {
        
    }
    
    @IBAction func didClickOnDisplayContactsButton(sender: AnyObject)
    {
        
    }

    @IBAction func disClickOnSearchButton(sender: AnyObject)
    {
        
    }
    
    //MARK: SearchBar delegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        searchingStoredContacts(searchBar.text!)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText == ""
        {
            filterdAlphabeticSortingDict.removeAllObjects();
            filteredAlphabeticArray.removeAllObjects();
            filteredDisplayingContacts.removeAllObjects();
            
            reloadTableData()
        }
    }
    

    func searchingStoredContacts(searchText: String)
    {
        filteredArray = storedContactsArray!.filter({ (contacts) -> Bool in
            let tmp: NSString = contacts.firstName as! NSString
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        
        if filteredArray.count == 0
        {
            self.delegate.showAlert();
        }
        else
        {
            //Forming section header charecters
            formAlphabeticCharacters();
            reloadTableData();
        }
    }
    
    func formAlphabeticCharacters()
    {
        filterdAlphabeticSortingDict.removeAllObjects();
        filteredAlphabeticArray.removeAllObjects();
        
        for value in filteredArray
        {
            let innerArray:NSMutableArray = NSMutableArray();
            let contacts = value as! Contacts;
            let char = contacts.firstName?.characters.first;
            let array = filterdAlphabeticSortingDict.valueForKey(String(char));
            
            if array?.count != 0 && array != nil
            {
                innerArray.addObjectsFromArray(array as! [AnyObject]);
            }
            else
            {
                filteredAlphabeticArray.addObject(String(char));
            }
            innerArray.addObject(value);
            filterdAlphabeticSortingDict.setValue(innerArray, forKey: String(char));
        }
    }
    
    //MARK: Image picker view
    
}
