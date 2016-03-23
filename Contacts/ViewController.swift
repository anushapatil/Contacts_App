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
    var storedContacts:NSMutableArray = NSMutableArray()
    var customSubView:CustomSubView!;
    let testVC = TestViewController();
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Calling Objective C class method
        testVC.test();
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        intialization();
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
        
        if customSubView == nil
        {
            let nibView = self.view.loadFromNibNamed(Constants.ControllerConstants.customViewNibName)! as! CustomSubView
            customSubView = nibView
            
            createAddContactButton();
            setScrollViewOffset(CGRectGetMaxX(self.holderScrollView.frame));
        }
        
        fetchStoredContactsDetails();
        formAlphabeticCharacters();
        setCustomSubViewProperties();
        
    }
    
    
    func fetchStoredContactsDetails()
    {
        let dataBaseHandler = DataBaseHandler.sharedInstance;
        dataBaseHandler.fetchData();
        storedContacts = dataBaseHandler.storedContacts!
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
        customSubView.alphabeticArray = alphabeticArray;
        customSubView.alphabeticSortingDict = alphabeticSortingDict;
        customSubView.storedContactsArray = storedContacts;
        customSubView.delegate = self;
        
        customSubView.frame = CGRectMake(0, CGRectGetMinY(self.holderScrollView.bounds), CGRectGetWidth(self.holderScrollView.frame)*3, CGRectGetHeight(self.holderScrollView.frame));
        
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
        self.view.bringSubviewToFront(bottomBarView);
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
        setScrollViewOffset(CGRectGetWidth(self.holderScrollView.frame));
        bottomBarView.hidden = true;
        self.phoneKeyPadButton.selected = false;
        self.contactsButton.selected = true;
        self.groupContactsButton.selected = false;
    }
    
    @IBAction func didClickOnGroupContactsButton(sender: AnyObject)
    {
        setScrollViewOffset(CGRectGetWidth(self.holderScrollView.frame)*2);
        bottomBarView.hidden = true;
        self.phoneKeyPadButton.selected = false;
        self.contactsButton.selected = false;
        self.groupContactsButton.selected = true;
    }
    
    func didClickOnAddContactsButton()
    {
        self.performSegueWithIdentifier(Constants.ControllerConstants.identifier, sender: self);
    }
    
    func addDisplayViewController()
    {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("display")
        
        self.presentViewController(vc, animated: true) { () -> Void in
            
            let displayViewController = vc as! DisplayViewController
            displayViewController.view.backgroundColor = UIColor.whiteColor()
            
            let selectedContact = self.customSubView.getSelectedContact()
            displayViewController.displayNamePrefix.text = selectedContact.namePrefix
            displayViewController.firstNameDisplay.text  = selectedContact.firstName;
            displayViewController.middleNameDisplay.text = selectedContact.middleName;
            displayViewController.surnameDisplay.text = selectedContact.surname;
            displayViewController.nameSuffixDIsplay.text = selectedContact.nameSuffix;
            displayViewController.companyDisplay.text = selectedContact.company;
            displayViewController.titleDisplay.text = selectedContact.title;
            displayViewController.phoneNumberDisplay.text = selectedContact.phone;
            displayViewController.emailIDDisplay.text = selectedContact.email;
        }
    }
    
    //MARK: Perform segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == Constants.ControllerConstants.identifier
        {
            let addContactsVC = segue.destinationViewController as! AddContactsViewController;
            addContactsVC.delegate = self;
        }
        else if segue.identifier == Constants.ControllerConstants.displayIdentifier
        {
            
        }
    }
    
    //MARK: Custom delegate methods
    
    func reloadTableAfterAddingContacts()
    {
        fetchStoredContactsDetails();
        formAlphabeticCharacters();
        
        customSubView.reloadTableData();
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

