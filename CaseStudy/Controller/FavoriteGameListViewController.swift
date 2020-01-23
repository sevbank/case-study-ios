//
//  FavoriteGameListViewController.swift
//  CaseStudy
//
//  Created by Sevban Kocabas on 22.01.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import UIKit
import LBTATools

class FavoriteGameListViewController: LBTAListController<GameTableViewCell, GameModel>{
    
    fileprivate let placeholderLabel = UILabel(text: "There is no favourites found.", font: .appBoldFontWith(size: 18), textColor: .black, textAlignment: .center, numberOfLines: 1)
    
    lazy var refresher: UIRefreshControl = {
       let r = UIRefreshControl()
        r.tintColor = .buttonColor
        r.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return r
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        fetchGames()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func refresh() {
        fetchGames()
    }
    
    private func fetchGames() {
        self.refresher.beginRefreshing()
        Service.shared.fetchFavoriteGames { [weak self] (gameList, error) in
            guard let `self` = self else {return}
            if let error = error {
                AlertViewManager.instance.showAlertController(withTitle:"Error", andMessage:error.localizedDescription, viewController:self)
                return
            }
            self.placeholderLabel.isHidden = !(gameList?.isEmpty ?? true)
            self.navigationItem.title = (gameList?.isEmpty ?? true) ? "Favorites" : "Favorites (\(gameList?.count ?? 0))"
            self.items = gameList ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.refresher.endRefreshing()
            }
        }
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .backgroundColor
        collectionView.alwaysBounceVertical = true
        
        let statusBarCover = UIView(backgroundColor: .backgroundColor)
        view.addSubview(statusBarCover)
        statusBarCover.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
        
        collectionView.refreshControl = refresher
        view.addSubview(placeholderLabel)
        placeholderLabel.anchor(top: statusBarCover.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 70, left: 0, bottom: 0, right: 0))
    }
    

}


extension FavoriteGameListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 136)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gameID = self.items[indexPath.item].id
        let gameDetailViewController = GameDetailViewController(gameID: gameID ?? 0)
        self.navigationController?.pushViewController(gameDetailViewController, animated: true)
    }
    

}
