//
//  ViewController.swift
//  Contacts
//
//  Created by Anusha Patil on 05/03/2016.
//  Copyright © 2016 Anusha Patil. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    //MARK: Images view outlets
    @IBOutlet weak var dropdownImageView: UIImageView!
    
    //Table view outlets
    @IBOutlet weak var contactsTableView: UITableView!
    
    //MARK: Search bar outlets
    @IBOutlet weak var searchContactButton: UISearchBar!
    
    //MARK: Buttons outlets
    @IBOutlet weak var contactsToDisplayButton: UIButton!
    @IBOutlet weak var overFlowIcon: UIButton!
    @IBOutlet weak var phoneKeyPadButton: UIButton!
    @IBOutlet weak var groupContactsButton: UIButton!
    @IBOutlet weak var contactsButton: UIButton!
    
    //MARK: Global Variables
    var alphabeticContacts = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z";
    var array = [];
    let value:CGFloat = 50;
    let value1:CGFloat = 80;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        intialization();
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Custom Methods
    
    func intialization()
    {
        self.view.sendSubviewToBack(dropdownImageView);
        self.view.bringSubviewToFront(contactsToDisplayButton);
        //self.contactsToDisplayButton.addBorderToTheView();
        
        formAlphabeticCharacters();
        
        createAddContactButton();
    }
    
    func formAlphabeticCharacters()
    {
        array = alphabeticContacts.componentsSeparatedByString(" ");
    }

    func createAddContactButton()
    {
        let addContactsButton = UIButton();
        addContactsButton.frame = CGRectMake(CGRectGetMaxX(self.view.frame)-value1, CGRectGetMaxY(self.view.frame)-value1, value, value);
        addContactsButton.setImage(UIImage(named: "plus.png"), forState:UIControlState.Normal);
        //addContactsButton.backgroundColor = UIColor(hexString: "#25B7B7");
        addContactsButton.layer.borderColor = UIColor.redColor().CGColor;
        addContactsButton.layer.borderWidth = 1.0;
        addContactsButton.backgroundColor = UIColor.whiteColor();
        addContactsButton.layer.cornerRadius = addContactsButton.frame.size.width/2;
        addContactsButton.addTarget(self , action: "didClickOnAddContactsButton", forControlEvents: UIControlEvents.TouchUpInside);
        addContactsButton.translatesAutoresizingMaskIntoConstraints = true;
        self.view.addSubview(addContactsButton);
        self.view.bringSubviewToFront(addContactsButton);
    }
    
    //MARK: Action Methods
    
    @IBAction func didClickOnGroupContactsButton(sender: AnyObject)
    {
        
    }
    
    @IBAction func didClickOnContactsButton(sender: AnyObject)
    {
        
    }
    
    @IBAction func didClickOnPhoneKeypadButton(sender: AnyObject)
    {
        
    }
    
    @IBAction func didClickOnOverFlowButton(sender: AnyObject)
    {
        
    }
    
    @IBAction func didClickOnDisplayContactsButton(sender: AnyObject)
    {
        
    }
    
    func didClickOnAddContactsButton()
    {
        self.performSegueWithIdentifier("push", sender: self);
    }
    
    //MARK: Perform segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "push"
        {
            
        }
    }
    
    //MARK: Table view delegate and datasource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 26;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return 1;
        }
        return 3;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = self.contactsTableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath);
        if indexPath.row == 1
        {
            //cell.textLabel?.text = "SET UP MY PROFILE";
        }
        cell.imageView?.image = UIImage (named: "person.png");
        cell.textLabel!.text = "222";
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
            text = (array.objectAtIndex(section-1) as? String)!;
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
    
}

