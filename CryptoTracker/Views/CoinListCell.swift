//
//  CoinListCell.swift
//  CryptoTracker
//
//  Created by Charles Edwards on 9/18/23.
//

import Foundation
import UIKit
import Kingfisher
class CoinListCell: UICollectionViewCell {
    
    var data: Coin? {
        didSet{
            configData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configViews()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var container: UIView = {
        let container = UIView()
        container.backgroundColor = .secondarySystemBackground
        container.layer.cornerRadius = 8
        container.layer.borderWidth = 0.5
        container.layer.borderColor = UIColor.tertiarySystemBackground.cgColor
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
        }()
    
    var coinImage : UIImageView = {
        var img = UIImageView()
        img.image = UIImage()
        img.backgroundColor = .clear
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
        }()
    
    var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.numberOfLines = 4
        label.lineBreakMode = .byWordWrapping
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()
    
    var symbolLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()
    
    var priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()
    
    var border: UIView = {
        let border = UIView()
        border.backgroundColor = .tertiarySystemBackground
        border.translatesAutoresizingMaskIntoConstraints = false
        return border
        }()
    
    var fillerone: UIView = {
        let filler = UIView()
        filler.backgroundColor = .clear
        filler.translatesAutoresizingMaskIntoConstraints = false
        return filler
        }()
    var fillertwo: UIView = {
        let filler = UIView()
        filler.backgroundColor = .clear
        filler.translatesAutoresizingMaskIntoConstraints = false
        return filler
        }()
    var fillerthree: UIView = {
        let filler = UIView()
        filler.backgroundColor = .clear
        filler.translatesAutoresizingMaskIntoConstraints = false
        return filler
        }()
    
    var coinDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var coinValueStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var oneHrStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var oneHrLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = "1h"
        label.font = .preferredFont(forTextStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var oneHourHistory: CoinHistory = {
        let coinHistory = CoinHistory()
        coinHistory.translatesAutoresizingMaskIntoConstraints = false
        return coinHistory
    }()
    
    var twentyFourHrStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var twentyFourHourLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = "24h"
        label.font = .preferredFont(forTextStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var twentyFourHourHistory: CoinHistory = {
        let coinHistory = CoinHistory()
        coinHistory.translatesAutoresizingMaskIntoConstraints = false
        return coinHistory
    }()
    
    var sevenDayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var sevenDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = "7d"
        label.font = .preferredFont(forTextStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sevenDayHistory: CoinHistory = {
        let coinHistory = CoinHistory()
        coinHistory.translatesAutoresizingMaskIntoConstraints = false
        return coinHistory
    }()
    
    func configViews(){
        addSubview(container)
        
        [coinDataStackView, border, coinValueStackView].forEach{
            container.addSubview($0)
                 }
        
        [coinImage, nameLabel, symbolLabel,priceLabel].forEach{
            coinDataStackView.addArrangedSubview($0)
                 }
        
        [oneHrStackView, twentyFourHrStackView, sevenDayStackView].forEach{
            coinValueStackView.addArrangedSubview($0)
                 }
        
        [oneHrLabel, oneHourHistory, fillerone].forEach{
            oneHrStackView.addArrangedSubview($0)
                 }
        
        
        [twentyFourHourLabel, twentyFourHourHistory, fillertwo].forEach{
            twentyFourHrStackView.addArrangedSubview($0)
                 }
        
        [sevenDayLabel, sevenDayHistory, fillerthree].forEach{
            sevenDayStackView.addArrangedSubview($0)
                 }
            
            
            
        }
        
        
        func configConstraints(){
            NSLayoutConstraint.activate([
                container.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
                container.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
                
                trailingAnchor.constraint(equalToSystemSpacingAfter: container.trailingAnchor, multiplier: 1),
                bottomAnchor.constraint(equalToSystemSpacingBelow: container.bottomAnchor, multiplier: 1),
              
               
                coinDataStackView.topAnchor.constraint(equalToSystemSpacingBelow:  container.topAnchor, multiplier: 2),
                coinDataStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
                coinDataStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
                
                coinImage.widthAnchor.constraint(equalToConstant: 80),
                coinImage.heightAnchor.constraint(equalToConstant: 80),
                coinImage.topAnchor.constraint(equalToSystemSpacingBelow: container.topAnchor, multiplier: 2),
                coinImage.leadingAnchor.constraint(equalToSystemSpacingAfter: container.leadingAnchor, multiplier: 2),
                
                
                nameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
                nameLabel.leadingAnchor.constraint(equalTo: coinImage.trailingAnchor, constant: 10),
                
                
                symbolLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 5),
                priceLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
                
                
                border.bottomAnchor.constraint(equalTo: coinValueStackView.topAnchor, constant: -10),
                border.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
                border.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
                border.heightAnchor.constraint(equalToConstant: 1),
                
                coinValueStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
                trailingAnchor.constraint(equalToSystemSpacingAfter: coinValueStackView.trailingAnchor, multiplier: 1),
                bottomAnchor.constraint(equalToSystemSpacingBelow: coinValueStackView.bottomAnchor, multiplier: 2),
                
                
                oneHrStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: coinValueStackView.leadingAnchor, multiplier: 2),
                oneHourHistory.widthAnchor.constraint(equalToConstant: 74),
                oneHourHistory.heightAnchor.constraint(equalToConstant: 30),
                fillerone.widthAnchor.constraint(equalToConstant: 8),
                
                twentyFourHrStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: oneHrStackView.trailingAnchor, multiplier: 2),
                twentyFourHourHistory.widthAnchor.constraint(equalToConstant: 74),
                twentyFourHourHistory.heightAnchor.constraint(equalToConstant: 30),
                fillertwo.widthAnchor.constraint(equalToConstant: 8),
                
                sevenDayStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: twentyFourHrStackView.trailingAnchor, multiplier: 2),
                sevenDayHistory.widthAnchor.constraint(equalToConstant: 74),
                sevenDayHistory.heightAnchor.constraint(equalToConstant: 30),
                fillerthree.widthAnchor.constraint(equalToConstant: 8),
                trailingAnchor.constraint(equalToSystemSpacingAfter: sevenDayStackView.trailingAnchor, multiplier: 1),
            ])
        }
    
    
    func configData(){
        guard let item = data else { return }
        nameLabel.text = item.name
        
        let coinUrl = "\(coinImageBaseUrl)\(item.symbol.lowercased()).png"
        coinImage.kf.setImage(with: URL(string: coinUrl))
        
        let priceString = item.quote["USD"]!.price.currencyFormat
        priceLabel.text = priceString
        
        oneHourHistory.data = item.quote["USD"]!.percent_change_1h
        
        twentyFourHourHistory.data = item.quote["USD"]!.percent_change_24h
        
        sevenDayHistory.data = item.quote["USD"]!.percent_change_7d
        
        symbolLabel.text = "(\(item.symbol))"
            
        }
    
    
        
    
}
