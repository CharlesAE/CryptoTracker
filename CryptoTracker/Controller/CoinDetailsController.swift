//
//  CoinDetailsController.swift
//  CryptoTracker
//
//  Created by Charles Edwards on 9/21/23.
//

import Foundation
import UIKit
import Combine
import Kingfisher

class CoinDetailsController: UIViewController {
    let coinDetailsID = "CoinDetailsCell"
    
    private let viewModel = CoinDetailViewModel()
    var data: Coin? {
        didSet{
            DispatchQueue.main.async {
                print(self.data!)
                self.fetchCoinDetails(id: "\(self.data!.id)")
                
            }
        }
    }
    private var cancellables = Set<AnyCancellable>()
    private var coin: CoinDetail?{
        didSet{
            
            configData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
       
        configViews()
        configConstraints()
    }
    
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
    
    let iconContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var coinImage : UIImageView = {
        var img = UIImageView()
        img.image = UIImage()
        img.backgroundColor = .clear
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
        }()
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let marketCap: CoinDetailsContainer = {
        let marketCap = CoinDetailsContainer()
        marketCap.translatesAutoresizingMaskIntoConstraints = false
        return marketCap
    }()
    
    let volumeOneDay: CoinDetailsContainer = {
        let volumeOneDay = CoinDetailsContainer()
        volumeOneDay.translatesAutoresizingMaskIntoConstraints = false
        return volumeOneDay
    }()
    let totalSupply : CoinDetailsContainer = {
        let totalSupply = CoinDetailsContainer()
        totalSupply.translatesAutoresizingMaskIntoConstraints = false
        return totalSupply
    }()
    let fullyDiluted : CoinDetailsContainer = {
        let fullyDiluted = CoinDetailsContainer()
        fullyDiluted.translatesAutoresizingMaskIntoConstraints = false
        return fullyDiluted
    }()
    
    let percentOneHour : CoinDetailsContainer = {
        let percentOneHour = CoinDetailsContainer()
        percentOneHour.translatesAutoresizingMaskIntoConstraints = false
        return percentOneHour
    }()
    
    let percentOneDay : CoinDetailsContainer = {
        let percentOneDay = CoinDetailsContainer()
        percentOneDay.translatesAutoresizingMaskIntoConstraints = false
        return percentOneDay
    }()
    func configViews(){
        view.addSubview(loader)
        view.addSubview(label)
        loader.fillSuperview()
        label.fillSuperview()
        view.addSubview(iconContainer)
        iconContainer.addSubview(coinImage)
        view.addSubview(detailsLabel)
        view.addSubview(volumeOneDay)
        view.addSubview(marketCap)
        
                
        view.addSubview(totalSupply)
        view.addSubview(fullyDiluted)
    }
    
    func configConstraints(){
        NSLayoutConstraint.activate([
            iconContainer.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3),
            iconContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconContainer.heightAnchor.constraint(equalToConstant: 100),
            
            coinImage.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            coinImage.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            coinImage.heightAnchor.constraint(equalToConstant: 100),
            coinImage.widthAnchor.constraint(equalToConstant: 100),
            
            detailsLabel.topAnchor.constraint(equalToSystemSpacingBelow: iconContainer.bottomAnchor, multiplier: 3),
            detailsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: detailsLabel.trailingAnchor, multiplier: 1),
            
            marketCap.topAnchor.constraint(equalToSystemSpacingBelow: detailsLabel.bottomAnchor, multiplier: 2),
            marketCap.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: marketCap.trailingAnchor, multiplier: 1),
            
            
            
            volumeOneDay.topAnchor.constraint(equalToSystemSpacingBelow: marketCap.bottomAnchor, multiplier: 1),
            volumeOneDay.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: volumeOneDay.trailingAnchor, multiplier: 1),
            
            
            totalSupply.topAnchor.constraint(equalToSystemSpacingBelow: volumeOneDay.bottomAnchor, multiplier: 1),
            totalSupply.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: totalSupply.trailingAnchor, multiplier: 1),
            
            fullyDiluted.topAnchor.constraint(equalToSystemSpacingBelow: totalSupply.bottomAnchor, multiplier: 1),
            fullyDiluted.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: fullyDiluted.trailingAnchor, multiplier: 1),
                    ])
    }
    func configAttributedText(_ text1: String, _ text2: String) -> NSAttributedString {
        let text = NSMutableAttributedString(attributedString: NSAttributedString(string: "\(text1).", attributes: [NSAttributedString.Key.foregroundColor: UIColor.label ,NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]))
        text.append(NSAttributedString(string: "\n\n\(text2)", attributes: [NSAttributedString.Key.foregroundColor:UIColor.label,NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)]))
            return text
        }
    func configData(){
        
        navigationItem.title = data?.name
        
        let splitDetails = coin!.description
        let splitStringArray = splitDetails.split(separator: ".", maxSplits: 1).map(String.init)

        detailsLabel.attributedText = configAttributedText(splitStringArray[0], splitStringArray[1])
        let coinUrl = "\(coinImageBaseUrl)\(data!.symbol.lowercased()).png"
        coinImage.kf.setImage(with: URL(string: coinUrl))
        marketCap.data = CoinDetailsContainerData(label: "Market cap", value: data!.quote["USD"]!.market_cap, change: data!.quote["USD"]!.percent_change_24h)
        volumeOneDay.data = CoinDetailsContainerData(label: "Volume (24h)", value: data!.quote["USD"]!.volume_24h, change: data!.quote["USD"]!.volume_change_24h)
        totalSupply.data = CoinDetailsContainerData(label: "Total Supply", value: data!.total_supply)
        fullyDiluted.data = CoinDetailsContainerData(label: "Fully diluted market cap", value: data!.quote["USD"]!.fully_diluted_market_cap)
    }
    
    func fetchCoinDetails(id:String){
        viewModel.fetchCoin(id: id)
            .sink {
                [weak self] completion in
                switch completion{
                case .success(let coin):
                    self?.coin = coin
                    
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
    
}


