//
//  GameDescriptionTableViewCell.swift
//  CaseStudy
//
//  Created by Sevban Kocabas on 22.01.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import UIKit

class GameDescriptionTableViewCell: UITableViewCell {
    
    let descriptionLabel = UILabel(text: "Game Description", font: .appBoldFontWith(size: 18), textColor: .black, textAlignment: .left, numberOfLines: 1)
    let gameDescriptionLabel = UILabel(text: "", font: .appRegularFontWith(size: 12), textColor: .darkGray, textAlignment: .left, numberOfLines: 0)
    
    let containerView = UIView()
    
    
    
    var gameModel: GameModel! {
        didSet {
            self.gameDescriptionLabel.text = self.gameModel.description?.html2String
            
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(containerView)
        containerView.fillSuperview(padding: .allSides(16))
        
        containerView.stack(descriptionLabel,
                             gameDescriptionLabel,
                             spacing: 8,
                             alignment: .leading,
                             distribution: .equalSpacing)
        addSeparatorView(padding: 16)
        selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
