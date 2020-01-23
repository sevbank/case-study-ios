//
//  LinkTableViewCell.swift
//  CaseStudy
//
//  Created by Sevban Kocabas on 22.01.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import UIKit

class LinkTableViewCell: UITableViewCell {
    
    let linkLabel = UILabel(text: "Visit Reddit", font: .appBoldFontWith(size: 16), textColor: .black, textAlignment: .left, numberOfLines: 1)
   
    
    let containerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(containerView)
        containerView.withHeight(54)
        containerView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        containerView.addSubview(linkLabel)
        linkLabel.fillSuperview()
        addSeparatorView(padding: 16)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



