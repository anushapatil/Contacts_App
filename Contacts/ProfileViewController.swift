//
//  ProfileViewController.swift
//  Contacts
//
//  Created by Vanashri on 25/03/16.
//  Copyright © 2016 Anusha Patil. All rights reserved.
//

import UIKit

protocol ProfileViewControllerDelegate
{
    func updatedProfilePic(image:UIImage);
}

class ProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var imagePicker:UIImagePickerController!
    var delegate:ProfileViewControllerDelegate!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        if imagePicker == nil
        {
            imagePicker = UIImagePickerController();
            
            imagePicker.delegate = self
            
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .PhotoLibrary
            
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: ImagePickerView delegates

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageView.contentMode = .ScaleAspectFit
            profileImageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
   //MARK: Action methods
    
    @IBAction func didTapOnUploadProfilePicButton(sender: AnyObject)
    {
        self.delegate.updatedProfilePic(profileImageView.image!);
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func getProfileImageViewImage()->UIImage
    {
        return profileImageView.image!;
    }
}
