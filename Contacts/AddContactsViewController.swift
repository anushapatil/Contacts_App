//
//  AddContactsViewController.swift
//  Contacts
//
//  Created by Anusha Patil on 12/03/2016.
//  Copyright © 2016 Anusha Patil. All rights reserved.
//

import UIKit

protocol AddContactsViewControllerDelegate
{
    func reloadTableAfterAddingContacts()
}

class AddContactsViewController: UIViewController
{
    // MARK: Outlet deaclaration
    
    @IBOutlet weak var namePrefixTextfield: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var middleNameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameSuffixTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var groupNameButton: UIButton!
    
    @IBOutlet weak var phoneSideButton: UIButton!
    @IBOutlet weak var emailSideButton: UIButton!
    @IBOutlet weak var addressSideButton: UIButton!
    @IBOutlet weak var specialDatesSideButton: UIButton!
    
    var delegate: AddContactsViewControllerDelegate!
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
    }
    
    // MARK: Action methods
    
    @IBAction func didClickOnProfilePicSelectionButton(sender: AnyObject)
    {
        
    }
    
    @IBAction func specialDatesSideButtonClicked(sender: AnyObject)
    {
        
    }
    
    @IBAction func emailSideButtonClicked(sender: AnyObject)
    {
        
    }
    
    @IBAction func addressSideButtonClicked(sender: AnyObject)
    {
        
    }
    
    @IBAction func phoneSideButtonClicked(sender: AnyObject)
    {
        
    }
    
    @IBAction func didClickOnGroupNameDropDownButton(sender: AnyObject)
    {
        
    }
    
    @IBAction func didClickOnDatePickerButton(sender: AnyObject)
    {
        
    }
    
    @IBAction func didClickOnDoneButton(sender: AnyObject)
    {
        if firstNameTextField.text != ""
        {
            let addContactsModel:AddContactsModel = prepareContactsModel();
            let dataBaseHandle = DataBaseHandler.sharedInstance;
            dataBaseHandle.savingContactsWithDetails(addContactsModel);

        }
        
        //Call delegate method
        delegate.reloadTableAfterAddingContacts();
        
        //dismiss view controller
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            NSLog("completed animation");
        }
    }
    
    //MARK: Custom methods
    
    func prepareContactsModel() -> (AddContactsModel)
    {
        let addContactsModel = AddContactsModel();
        addContactsModel.namePrefix = self.namePrefixTextfield.text;
        addContactsModel.firstName = self.firstNameTextField.text;
        addContactsModel.middleName = self.middleNameTextField.text;
        addContactsModel.surname = self.surnameTextField.text;
        addContactsModel.namePrefix = self.nameSuffixTextField.text;
        addContactsModel.company = self.companyTextField.text;
        addContactsModel.title = self.titleTextField.text;
        addContactsModel.phone = self.phoneTextField.text;
        addContactsModel.email = self.emailTextField.text;
        addContactsModel.address = self.addressTextField.text;
        addContactsModel.date = self.dateLabel.text;
        addContactsModel.groupName = self.groupNameButton.titleLabel?.text;
        addContactsModel.phoneType = self.phoneSideButton.titleLabel?.text;
        addContactsModel.emailType = self.emailSideButton.titleLabel?.text;
        addContactsModel.addressType = self.addressSideButton.titleLabel?.text;
        addContactsModel.specialDatesType = self.specialDatesSideButton.titleLabel?.text;
    
        return addContactsModel;
    }
    //MARK TextFiled delegate methods
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        return true;
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        var value = true;
        
        if textField == emailTextField
        {
            value = isValidEmail(textField.text!);
        }
//        else if textField == phoneTextField
//        {
//            value = validate(textField.text!)
//        }
        
        if !value && textField.text != ""
        {
            let alertController = UIAlertController(title: "Error", message: "Please enter valid data!!!", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Default, handler: { (ACTION) -> Void in
                
            });
            
            alertController.addAction(okAction);
            self.presentViewController(alertController, animated: true, completion: { () -> Void in
                textField.text = "";
            });
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder();
        return true;
    }
    
    //MARK: Validate Phone number and Email ID
    
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(testStr)
        return result
    }
    
    func validate(value: String) -> Bool
    {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluateWithObject(value)
        return result
    }
}
