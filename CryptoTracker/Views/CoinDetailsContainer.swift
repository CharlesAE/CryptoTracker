//
//  CoinDetailsContainer.swift
//  CryptoTracker
//
//  Created by Charles Edwards on 9/22/23.
//

import Foundation
import UIKit

class CoinDetailsContainer: UIView {
    var data : CoinDetailsContainerData? {
        didSet{
            configData()
            configViews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //configViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.tertiaryLabel.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        }()
    
    var twentyFourHourHistory: CoinHistory = {
        let coinHistory = CoinHistory()
        coinHistory.translatesAutoresizingMaskIntoConstraints = false
        return coinHistory
    }()
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()
    
    let value: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .caption2)
        label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()


    func configViews(){
       addSubview(container)
        if((data?.change) != nil) {
            [label,value, twentyFourHourHistory].forEach{
                         container.addSubview($0)
                     }
            configConstraints(withIcon: true)
        }
        else{
            [label,value].forEach{
                         container.addSubview($0)
                     }
            configConstraints(withIcon: false)
        }
       
    }
    func configConditionalConstraints(){
        
    }
    func configConstraints(withIcon: Bool){
        
        if(withIcon) {
            NSLayoutConstraint.activate([
                container.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 0),
                container.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 0),
                container.heightAnchor.constraint(equalToConstant: 50),
                bottomAnchor.constraint(equalToSystemSpacingBelow: container.bottomAnchor, multiplier: 1),
                trailingAnchor.constraint(equalToSystemSpacingAfter: container.trailingAnchor, multiplier: 0),
                
                
                label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                label.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
                label.heightAnchor.constraint(equalToConstant: 24),
                
                value.centerYAnchor.constraint(equalTo: label.centerYAnchor),
                value.leadingAnchor.constraint(equalToSystemSpacingAfter: label.trailingAnchor, multiplier: 2),
                
                
                twentyFourHourHistory.centerYAnchor.constraint(equalTo: label.centerYAnchor),
                twentyFourHourHistory.widthAnchor.constraint(equalToConstant: 74),
                twentyFourHourHistory.heightAnchor.constraint(equalToConstant: 30),
                trailingAnchor.constraint(equalToSystemSpacingAfter: twentyFourHourHistory.trailingAnchor, multiplier: 3),
                
                
            ])
        }
        else {
            NSLayoutConstraint.activate([
                
                container.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 0),
                container.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 0),
                container.heightAnchor.constraint(equalToConstant: 50),
                bottomAnchor.constraint(equalToSystemSpacingBelow: container.bottomAnchor, multiplier: 1),
                trailingAnchor.constraint(equalToSystemSpacingAfter: container.trailingAnchor, multiplier: 0),
                
                            
                label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                label.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
                label.heightAnchor.constraint(equalToConstant: 24),
                            
                value.centerYAnchor.constraint(equalTo: label.centerYAnchor),
                trailingAnchor.constraint(equalToSystemSpacingAfter: value.trailingAnchor, multiplier: 3),
                
            ])
        }
        }
    
    func configData(){
        guard let coinData = data else { return }
        
        twentyFourHourHistory.data = coinData.change
        label.text = coinData.label
        
        value.text = coinData.value.currencyFormat
            
        }
}
