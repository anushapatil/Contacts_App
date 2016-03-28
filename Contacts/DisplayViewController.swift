//
//  DisplayViewController.swift
//  Contacts
//
//  Created by Anusha Patil on 21/03/2016.
//  Copyright © 2016 Anusha Patil. All rights reserved.
//

import UIKit

protocol DisplayViewControllerDelegate
{
    func reloadTableAfterAddingContacts()
}

class DisplayViewController: UIViewController {

    @IBOutlet weak var acivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var displayNamePrefix: UITextField!
    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var firstNameDisplay: UITextField!
    @IBOutlet weak var middleNameDisplay: UITextField!
    @IBOutlet weak var surnameDisplay: UITextField!
    @IBOutlet weak var nameSuffixDIsplay: UITextField!
    @IBOutlet weak var companyDisplay: UITextField!
    @IBOutlet weak var titleDisplay: UITextField!
    @IBOutlet weak var phoneNumberDisplay: UITextField!
    @IBOutlet weak var emailIDDisplay: UITextField!
    @IBOutlet weak var addressDisplay: UITextField!
    var firstNameString = ""
    let dataBaseHandler = DataBaseHandler.sharedInstance;
    var delegate:DisplayViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewDidAppear(animated);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Action methods
    
    @IBAction func didClickOnEditButton(sender: AnyObject)
    {
        
    }

    @IBAction func didClickOnDoneButton(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil);
        
        let updatedContact = preparingData();
        dataBaseHandler.updateData(firstNameString, updatedData: updatedContact)
        
        self.delegate.reloadTableAfterAddingContacts();
    }
    
    @IBAction func didClickOnDeleteButton(sender: AnyObject)
    {
        self.acivityIndicator.hidden = false;
        self.acivityIndicator.startAnimating();
        dataBaseHandler.deleteDataBaseRecord(firstNameString);
        
        self.dismissViewControllerAnimated(true, completion: nil);
        self.delegate.reloadTableAfterAddingContacts();
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func preparingData() -> AddContactsModel
    {
        let addContactsModel = AddContactsModel();
        addContactsModel.namePrefix = self.displayNamePrefix.text;
        addContactsModel.firstName = self.firstNameDisplay.text;
        addContactsModel.middleName = self.middleNameDisplay.text;
        addContactsModel.surname = self.surnameDisplay.text;
        addContactsModel.nameSuffix = self.nameSuffixDIsplay.text;
        addContactsModel.company = self.companyDisplay.text;
        addContactsModel.title = self.titleDisplay.text;
        addContactsModel.phone = self.phoneNumberDisplay.text;
        addContactsModel.email = self.emailIDDisplay.text;
        addContactsModel.address = self.addressDisplay.text;
        
        return addContactsModel;
    }

}
