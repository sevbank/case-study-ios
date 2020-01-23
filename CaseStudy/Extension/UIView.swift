//
//  UIView.swift
//  CaseStudy
//
//  Created by Sevban Kocabas on 23.01.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import UIKit

extension UIView {
    func addSeparatorView(padding: CGFloat = 0) {
        let separatorView = UIView(backgroundColor: .gray)
        self.addSubview(separatorView)
        separatorView.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: padding, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
    }
}
