//
//  GameDetailHeaderView.swift
//  CaseStudy
//
//  Created by Sevban Kocabas on 22.01.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import UIKit
import LBTATools
import SDWebImage

class GameDetailHeaderView: UITableViewHeaderFooterView {
    
    let gameCoverImageView = UIImageView()
    let gameTitleLabel = UILabel(text: "", font: .appBoldFontWith(size: 36), textColor: .white, textAlignment: .center, numberOfLines: 1)
    let containerView = UIView()
    fileprivate let gradientLayer = CAGradientLayer()
    
    var gameModel: GameModel! {
        didSet {
            self.gameCoverImageView.sd_setImage(with: URL(string: self.gameModel.background_image!)!, completed: nil)
            self.gameTitleLabel.text = self.gameModel.name

        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(containerView)
        containerView.fillSuperview()
        gameCoverImageView.contentMode = .scaleAspectFill
        gameCoverImageView.clipsToBounds = true
        containerView.addSubview(gameCoverImageView)
        gameCoverImageView.fillSuperview()
        setupGradientLayer()
        gameCoverImageView.addSubview(gameTitleLabel)
        
        gameTitleLabel.adjustsFontSizeToFitWidth = true
        gameTitleLabel.anchor(top: nil, leading: containerView.leadingAnchor, bottom: bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        gameCoverImageView.bringSubviewToFront(gameTitleLabel)
        
        
    }
    
    fileprivate func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.3]
        
        gameCoverImageView.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        // in here you know what you CardView frame will be
        gradientLayer.frame = self.frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
