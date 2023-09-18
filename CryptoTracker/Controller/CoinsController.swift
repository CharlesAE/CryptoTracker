//
//  CoinsController.swift
//  CryptoTracker
//
//  Created by Charles Edwards on 9/18/23.
//

import Foundation
import UIKit
import Combine

class CoinsController: UICollectionViewController {
    let coinCell = "CoinCell"
    private var coins = [Coin](){
        didSet{
            collectionView.reloadData()
        }
    }
    
    private let viewModel = CoinViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    let loader: UIActivityIndicatorView = {
        var loader = UIActivityIndicatorView(style: .large)
        loader.color = .secondaryLabel
        loader.startAnimating()
        loader.hidesWhenStopped = true
        return loader
        }()
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.isHidden = true
        return label
        }()
    
    init() {
        let layout = UICollectionViewCompositionalLayout (section: Layouts.shared.coinSection())
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        configCollectionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoins()
    }

    private func configCollectionView(){
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CoinListCell.self, forCellWithReuseIdentifier: coinCell)
        view.addSubview(loader)
        view.addSubview(label)
        loader.fillSuperview()
        label.fillSuperview()
    }
    private func fetchCoins(){
    viewModel.fetchCoins()
        .sink {
            [weak self] completion in
            switch completion{
            case .success(let coins):
                self?.coins = coins
                
            case .failed(let error):
                self?.label.text = error.localizedDescription
            case .loading(let loading):
                loading ? self?.loader.startAnimating() : self?.loader.stopAnimating()
                if(loading == false){
                    self?.label.isHidden = false
                    self?.loader.isHidden = true
                }
            }
        }
        .store(in: &cancellables)
        }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC = CoinDetailsController()
        VC.data = coins[indexPath.row]
        navigationController?.pushViewController(VC, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coins.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: coinCell, for: indexPath) as! CoinListCell
        cell.data =  coins[indexPath.row]
        return cell
    }
}



