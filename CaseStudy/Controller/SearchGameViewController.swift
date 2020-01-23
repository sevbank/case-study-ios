//
//  ViewController.swift
//  CaseStudy
//
//  Created by Sevban Kocabas on 22.01.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import UIKit
import LBTATools

class SearchGameViewController: LBTAListController<GameTableViewCell, GameModel>{
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let placeHolderLabel = UILabel(text: "No game has been searched.", font: .appRegularFontWith(size: 18), textColor: .black, textAlignment: .center, numberOfLines: 1)
    
    var timer: Timer?
    var page = 1
    let pageSize = 10
    var searchTerm: String?
    
    var fetchingMore = true
    
    override var items: [GameModel] {
        didSet {
            DispatchQueue.main.async {
                self.placeHolderLabel.isHidden = !(self.items.isEmpty)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        
    }
    
    private func fetchGames(with terms: String) {
        Service.shared.fetchGames(with: terms, pageSize: pageSize, page: page) { [weak self]
            (searchResponseModel, error) in
            guard let `self` = self else {return}
            if let error = error {
                AlertViewManager.instance.showAlertController(withTitle:"Error", andMessage:error.localizedDescription, viewController:self)
                return
            }
            self.fetchingMore = !(searchResponseModel?.results?.isEmpty ?? true)
            self.items.append(contentsOf: searchResponseModel?.results ?? [])
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = .backgroundColor
        collectionView.alwaysBounceVertical = true
        
        let statusBarCover = UIView(backgroundColor: .backgroundColor)
        view.addSubview(statusBarCover)
        statusBarCover.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
        setupSearchBar()
        view.addSubview(placeHolderLabel)
        placeHolderLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
    }
    

}

extension SearchGameViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.items = []
        self.searchTerm = nil
        if searchText.count > 3 {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                self.searchTerm = searchText
            self.fetchGames(with: searchText)
            })
        }
    }
    
}

extension SearchGameViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
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

extension SearchGameViewController {
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(self.collectionView.contentOffset.y >= (self.collectionView.contentSize.height - self.collectionView.bounds.size.height)) {
            if fetchingMore && !(searchTerm?.isEmpty ?? true) {
                page += 1
                self.fetchGames(with: self.searchTerm!)
            }
        }
    }
}
