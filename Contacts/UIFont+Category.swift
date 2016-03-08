//
//  UIFont+Category.swift
//  Contacts
//
//  Created by Anusha Patil on 07/03/2016.
//  Copyright © 2016 Anusha Patil. All rights reserved.
//

import UIKit

extension UIFont
{
    func sizeOfString(string: String, containedWidth width:Double) -> CGSize
    {
        return NSString(string: string).boundingRectWithSize(CGSize(width: width+10, height: DBL_MAX),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: self],
            context: nil).size
    }
}