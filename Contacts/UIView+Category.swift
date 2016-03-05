//
//  UIView+Category.swift
//  Contacts
//
//  Created by Anusha Patil on 05/03/2016.
//  Copyright © 2016 Anusha Patil. All rights reserved.
//

import UIKit

extension UIView
{
    func addBorderToTheView()->UIView
    {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.redColor().CGColor;
        return self;
    }
    
}
