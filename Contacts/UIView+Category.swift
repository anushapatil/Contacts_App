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
        self.layer.borderWidth = 2.0;
        self.layer.borderColor = UIColor.lightGrayColor().CGColor;
        return self;
    }
    func addBottomBorder()->UIView
    {
        let layer = CALayer();
        self.layer.borderWidth = 1.0;
        layer.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame)+1.0, CGRectGetWidth(self.frame),1.0)
        self.layer.borderColor = UIColor.lightGrayColor().CGColor;
        self.layer.addSublayer(layer);
        return self;
    }
    
}
