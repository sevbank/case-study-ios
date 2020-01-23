//
//  GameDetailViewController.swift
//  CaseStudy
//
//  Created by Sevban Kocabas on 22.01.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import UIKit

class GameDetailViewController: UIViewController {
    
    init(gameID: Int) {
        self.gameID = gameID
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView = UITableView()
    var gameID: Int
    var gameModel: GameModel?
    let headerID = "GameDetailHeaderView"
    let descriptionCellID = "GameDescriptionTableViewCell"
    let linkCellID = "LinkTableViewCell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        fethGameDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc private func favoriteButtonTapped() {
        if FavouriteService.shared.isGameFavourite(ID: gameID) {
            FavouriteService.shared.deleteFavourite(with: gameID)
            navigationItem.rightBarButtonItem?.title = "Favorite"
        } else {
            FavouriteService.shared.saveFavourite(with: gameID)
            navigationItem.rightBarButtonItem?.title = "Favorited"
        }
    }
    
    private func fethGameDetail() {
        Service.shared.fetchGameDetail(with: gameID) {[weak self] (gameModel, error) in
            guard let `self` = self else {return}
            if let error = error {
                AlertViewManager.instance.showAlertController(withTitle:"Error", andMessage:error.localizedDescription, viewController:self)
                return
            }
            self.gameModel = gameModel
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    private func updateUI() {
        self.tableView.reloadData()
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .backgroundColor
        view.addSubview(tableView)
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.fillSuperview()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let rightButtonTitle = FavouriteService.shared.isGameFavourite(ID: gameID) ? "Favorited" : "Favorite"
        let statusBarCover = UIView(backgroundColor: .backgroundColor)
        view.addSubview(statusBarCover)
        statusBarCover.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
        navigationItem.setRightBarButton(UIBarButtonItem(title: rightButtonTitle, style: .plain, target: self, action: #selector(favoriteButtonTapped)), animated: true)
        tableView.register(GameDetailHeaderView.self, forHeaderFooterViewReuseIdentifier: headerID)
        tableView.register(GameDescriptionTableViewCell.self, forCellReuseIdentifier: descriptionCellID)
        tableView.register(LinkTableViewCell.self, forCellReuseIdentifier: linkCellID)
    }
    
}

extension GameDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: descriptionCellID, for: indexPath) as! GameDescriptionTableViewCell
            if let model = self.gameModel {
                cell.gameModel = model
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: linkCellID, for: indexPath) as! LinkTableViewCell
            cell.linkLabel.text = indexPath.item == 1 ? "Visit reddit" : "Visit website"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item != 0 {
            let link = indexPath.item == 1 ? gameModel?.reddit_url : gameModel?.website
            guard let url = URL(string: link ?? "") else {
                AlertViewManager.instance.showAlertController(withTitle: "Error", andMessage: "There is no link available", viewController: self)
                return
            }
            UIApplication.shared.open(url)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = GameDetailHeaderView()
        if let model = self.gameModel {
            view.gameModel = model
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 292
    }
    
    
}

