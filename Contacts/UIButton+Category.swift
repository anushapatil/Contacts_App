//
//  UIButton+Category.swift
//  Contacts
//
//  Created by Anusha Patil on 16/03/2016.
//  Copyright © 2016 Anusha Patil. All rights reserved.
//

import UIKit

extension UIButton
{
    func setButtonProperties()
    {
        self.setImage(UIImage(named: "plus.png"), forState:UIControlState.Normal);
        self.backgroundColor = UIColor(hexString: "#25B7B7");
        self.layer.borderColor = UIColor.redColor().CGColor;
        self.layer.borderWidth = 1.0;
        self.backgroundColor = UIColor.whiteColor();
        self.layer.cornerRadius = self.frame.size.width/2;
        self.translatesAutoresizingMaskIntoConstraints = true;
    }
}