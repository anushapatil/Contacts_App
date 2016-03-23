//
//  DisplayViewController.swift
//  Contacts
//
//  Created by Anusha Patil on 21/03/2016.
//  Copyright © 2016 Anusha Patil. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {

    @IBOutlet weak var displayNamePrefix: UITextField!
    @IBOutlet weak var firstNameDisplay: UITextField!
    @IBOutlet weak var middleNameDisplay: UITextField!
    @IBOutlet weak var surnameDisplay: UITextField!
    @IBOutlet weak var nameSuffixDIsplay: UITextField!
    @IBOutlet weak var companyDisplay: UITextField!
    @IBOutlet weak var titleDisplay: UITextField!
    @IBOutlet weak var phoneNumberDisplay: UITextField!
    @IBOutlet weak var emailIDDisplay: UITextField!
    @IBOutlet weak var addressDisplay: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didClickOnEditButton(sender: AnyObject) {
    }

    @IBAction func didClickOnDoneButton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
