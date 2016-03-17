//
//  ViewController.swift
//  Contacts
//
//  Created by Anusha Patil on 05/03/2016.
//  Copyright © 2016 Anusha Patil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AddContactsViewControllerDelegate, CustomSubViewDelegate, UIScrollViewDelegate
{
    @IBOutlet weak var phoneKeyPadButton: UIButton!
    @IBOutlet weak var groupContactsButton: UIButton!
    @IBOutlet weak var contactsButton: UIButton!
    @IBOutlet weak var saperatorLabel: UILabel!
    
    @IBOutlet weak var bottomBarView: UIView!
    @IBOutlet weak var holderScrollView: UIScrollView!
    //MARK: Global Variables
    var alphabeticSortingDict:NSMutableDictionary = NSMutableDictionary();
    var alphabeticArray:NSMutableArray = NSMutableArray();
    let value:CGFloat = 50;
    let value1:CGFloat = 80;
    var storedContacts = []
    var customSubView:CustomSubView!;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        intialization();
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        setCustomSubViewProperties();
        setScrollViewOffset(CGRectGetMaxX(self.holderScrollView.frame));
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib()
    {
        
    }
    
    //MARK: Custom Methods
    
    func intialization()
    {
        contactsButton.selected = true;
        bottomBarView.hidden = true;
        
        fetchStoredContactsDetails();
        formAlphabeticCharacters();
        createAddContactButton();
    }
    
    
    func fetchStoredContactsDetails()
    {
        let dataBaseHandler = DataBaseHandler.sharedInstance;
        dataBaseHandler.fetchData();
        storedContacts = dataBaseHandler.storedContacts;
    }
    
    func formAlphabeticCharacters()
    {
        alphabeticSortingDict.removeAllObjects();
        alphabeticArray.removeAllObjects();
        
        for value in storedContacts
        {
            let innerArray:NSMutableArray = NSMutableArray();
            let contacts = value as! Contacts;
            let char = contacts.firstName?.characters.first;
            let array = alphabeticSortingDict.valueForKey(String(char));
            
            if array?.count != 0 && array != nil
            {
                innerArray.addObjectsFromArray(array as! [AnyObject]);
            }
            else
            {
                alphabeticArray.addObject(String(char));
            }
            innerArray.addObject(value);
            alphabeticSortingDict.setValue(innerArray, forKey: String(char));
        }
    }
    
    func setCustomSubViewProperties()
    {
        let nibView = self.view.loadFromNibNamed(Constants.ControllerConstants.customViewNibName)! as! CustomSubView
        nibView.alphabeticArray = self.alphabeticArray
        nibView.alphabeticSortingDict = self.alphabeticSortingDict
        customSubView = nibView
        customSubView.alphabeticArray = alphabeticArray;
        customSubView.alphabeticSortingDict = alphabeticSortingDict;
        
        customSubView.frame = CGRectMake(CGRectGetMinX(self.holderScrollView.bounds), CGRectGetMinY(self.holderScrollView.bounds), CGRectGetWidth(self.holderScrollView.frame)*3, CGRectGetHeight(self.holderScrollView.frame));
        
        customSubView.translatesAutoresizingMaskIntoConstraints = true;
        
        self.holderScrollView.contentSize = CGSizeMake(CGRectGetWidth(holderScrollView.frame)*3, CGRectGetHeight(holderScrollView.frame));
        
        self.holderScrollView.addSubview(customSubView);
    }
    
    func createAddContactButton()
    {
        let addContactsButton = UIButton();
        addContactsButton.frame = CGRectMake(CGRectGetMaxX(self.view.frame)-value1, CGRectGetMaxY(self.view.frame)-value1, value, value);
        addContactsButton.setButtonProperties();
        addContactsButton.addTarget(self , action: "didClickOnAddContactsButton", forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(addContactsButton);
        self.view.bringSubviewToFront(addContactsButton);
    }
    
    func setScrollViewOffset(value: CGFloat)
    {
        self.holderScrollView.contentOffset = CGPointMake(value, CGRectGetMinY(self.holderScrollView.bounds));
    }
    
    //MARK: Action Methods
    
    @IBAction func didClickOnPhoneKeypadButton(sender: AnyObject)
    {
        setScrollViewOffset(CGRectGetMinX(self.holderScrollView.frame));
        bottomBarView.hidden = false;
        self.phoneKeyPadButton.selected = true;
        self.contactsButton.selected = false;
        self.groupContactsButton.selected = false;
    }
    
    @IBAction func didClickOnContactsButton(sender: AnyObject)
    {
        setScrollViewOffset(CGRectGetMaxX(self.holderScrollView.frame));
        bottomBarView.hidden = true;
        self.phoneKeyPadButton.selected = false;
        self.contactsButton.selected = true;
        self.groupContactsButton.selected = false;
    }
    
    @IBAction func didClickOnGroupContactsButton(sender: AnyObject)
    {
        setScrollViewOffset(CGRectGetMaxX(self.holderScrollView.frame)*2);
        bottomBarView.hidden = true;
        self.phoneKeyPadButton.selected = false;
        self.contactsButton.selected = false;
        self.groupContactsButton.selected = true;
    }
    
    func didClickOnAddContactsButton()
    {
        self.performSegueWithIdentifier(Constants.ControllerConstants.identifier, sender: self);
    }
    
    //MARK: Perform segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == Constants.ControllerConstants.identifier
        {
            let addContactsVC = segue.destinationViewController as! AddContactsViewController;
            addContactsVC.delegate = self;
        }
    }
    
    //MARK: Custom delegate methods
    
    func reloadTableAfterAddingContacts()
    {
        fetchStoredContactsDetails();
        formAlphabeticCharacters();
    }
    
    //MARK ScrollView Delegate methods
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        let point: CGPoint = scrollView.contentOffset;
        if point.x == 0
        {
            self.phoneKeyPadButton.selected = true;
            self.contactsButton.selected = false;
            self.groupContactsButton.selected = false;
            bottomBarView.hidden = false;
        }
        else if point.x == CGRectGetWidth(self.holderScrollView.frame)
        {
            self.phoneKeyPadButton.selected = false;
            self.contactsButton.selected = true;
            self.groupContactsButton.selected = false;
            bottomBarView.hidden = true;
        }
        else if point.x == (CGRectGetWidth(self.holderScrollView.frame)*2)
        {
            self.phoneKeyPadButton.selected = false;
            self.contactsButton.selected = false;
            self.groupContactsButton.selected = true;
            bottomBarView.hidden = true;
        }
    }
}

