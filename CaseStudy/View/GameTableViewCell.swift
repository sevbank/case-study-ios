//
//  GameTableViewCell.swift
//  CaseStudy
//
//  Created by Sevban Kocabas on 22.01.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import UIKit
import LBTATools
import SDWebImage

class GameTableViewCell: LBTAListCell<GameModel> {
    
    let containerView = UIView()
    let gameImageView = UIImageView(image: #imageLiteral(resourceName: "gameCover"))
    let gameTitleLabel = UILabel(text: "Grand Theft Auto V", font: .systemFont(ofSize: 20, weight: .heavy), textColor: .black, textAlignment: .center, numberOfLines: 1)
    let metacriticLabel = UILabel(text: "metacritic:", font: .systemFont(ofSize: 13, weight: .medium), textColor: .black, textAlignment: .left, numberOfLines: 1)
    let scoreLabel = UILabel(text: "14", font: .systemFont(ofSize: 18, weight: .bold), textColor: .red, textAlignment: .left, numberOfLines: 1)
    let genreLabel = UILabel(text: "action, puzzle", font: .systemFont(ofSize: 11, weight: .regular), textColor: .gray, textAlignment: .left, numberOfLines: 1)
    
    override var item: GameModel! {
        didSet {
            
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupLayout()
        
    }
    
    fileprivate func setupLayout() {
        backgroundColor = .white
        gameImageView.withSize(.init(width: 120, height: 104))
        addSubview(containerView)
        containerView.fillSuperview(padding: .allSides(16))
        
        containerView.hstack(gameImageView,
                             UIView().stack(gameTitleLabel,
                                            UIView().withHeight(25),
                                            UIView().hstack(metacriticLabel,
                                                            scoreLabel,
                                                            spacing: 6,
                                                            alignment: .leading,
                                                            distribution: .fill),
                                            genreLabel,
                                            spacing: 8,
                                            alignment: .leading,
                                            distribution: .fill),
                             spacing: 16,
                             alignment: .fill,
                             distribution: .fill)
    }


}
