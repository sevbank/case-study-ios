//
//  UIFont.swift
//  CaseStudy
//
//  Created by Sevban Kocabas on 23.01.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    class func appRegularFontWith(size:CGFloat) -> UIFont{
        return  UIFont.init(name: "SFProDisplay-Regular", size: size)!
    }
    class func appBoldFontWith(size:CGFloat) -> UIFont{
        return  UIFont(name: "SFProDisplay-Bold", size: size)!
    }
}
