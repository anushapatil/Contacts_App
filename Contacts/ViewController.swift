//
//  ViewController.swift
//  Contacts
//
//  Created by Anusha Patil on 05/03/2016.
//  Copyright © 2016 Anusha Patil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topBarStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        intialization();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func intialization()
    {
        self.topBarStackView.addBorderToTheView();
        self.topBarStackView.backgroundColor = UIColor.redColor();
    }


}

