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
    let gameTitleLabel = UILabel(text: "Grand Theft Auto V", font: .appBoldFontWith(size: 16), textColor: .black, textAlignment: .left, numberOfLines: 2)
    let metacriticLabel = UILabel(text: "metacritic:", font: .appRegularFontWith(size: 14), textColor: .black, textAlignment: .left, numberOfLines: 1)
    let scoreLabel = UILabel(text: "14", font: .appRegularFontWith(size: 16), textColor: .red, textAlignment: .left, numberOfLines: 1)
    let genreLabel = UILabel(text: "action, puzzle", font: .appRegularFontWith(size: 12), textColor: .gray, textAlignment: .left, numberOfLines: 1)
    
    override var item: GameModel! {
        didSet {
            if let urlString = item.background_image, let URL = URL(string: urlString) {
                self.gameImageView.sd_setImage(with: URL, completed: nil)
            }
            gameTitleLabel.text = item.name ?? ""
            scoreLabel.text = String(describing: item.metacritic ?? 0)
            var genreString = ""
            genreString = item.genres?.first?.name ?? ""
            if !(item.genres?.last?.name?.isEmpty ?? true ){
                genreString += ", "
            }
            genreString += item.genres?.last?.name ?? ""
            genreLabel.text = genreString
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupLayout()
        
    }
    
    fileprivate func setupLayout() {
        backgroundColor = .white
        gameImageView.contentMode = .scaleAspectFill
        gameImageView.clipsToBounds = true
        addSubview(containerView)
        containerView.fillSuperview(padding: .allSides(16))
        containerView.clipsToBounds = true
        gameImageView.withSize(.init(width: 120, height: 1004))
        containerView.hstack(gameImageView,
                             UIView().stack(gameTitleLabel,
                                            UIView().withHeight(30),
                                            UIView().hstack(metacriticLabel,
                                                            scoreLabel,
                                                            spacing: 6,
                                                            alignment: .leading,
                                                            distribution: .fill),
                                            genreLabel,
                                            spacing: 0,
                                            alignment: .leading,
                                            distribution: .fill),
                             spacing: 16,
                             alignment: .fill,
                             distribution: .fill)
    }
    
}
