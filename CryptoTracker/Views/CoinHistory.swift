//
//  CoinStatus.swift
//  CryptoTracker
//
//  Created by Charles Edwards on 9/18/23.
//

import Foundation
import UIKit

class CoinHistory: UIView {
    var data: Double? {
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
    
    lazy var icon : UIImageView = {
            var iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.translatesAutoresizingMaskIntoConstraints = false
            return iv
        }()
        
        lazy var statusLbl: UILabel = {
            let lbl = UILabel()
            lbl.font = .preferredFont(forTextStyle: .caption2)
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()


        func configViews(){
            layer.cornerRadius = 16
            addSubview(icon)
            addSubview(statusLbl)
        }
        
        func configConstraints(){
            NSLayoutConstraint.activate([
                icon.centerYAnchor.constraint(equalTo: centerYAnchor),
                icon.heightAnchor.constraint(equalToConstant: 16),
                icon.widthAnchor.constraint(equalToConstant: 16),
                icon.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
                
                statusLbl.centerYAnchor.constraint(equalTo: centerYAnchor),
                trailingAnchor.constraint(equalToSystemSpacingAfter: statusLbl.trailingAnchor, multiplier: 1)
            ])
        }
    
    func configData(){
        guard let item = data else { return }
        
        if item < 0 {
            statusLbl.textColor = redColor
            backgroundColor = redBackground
            icon.image = UIImage(systemName:"chart.line.downtrend.xyaxis")?.withRenderingMode(.alwaysOriginal)
            icon.tintColor = redColor
        }
        else {
            statusLbl.textColor = greenColor
            backgroundColor = greenBackground
            icon.image = UIImage(systemName:"chart.line.uptrend.xyaxis")?.withRenderingMode(.alwaysOriginal)
            icon.tintColor = greenColor
        }
        
        statusLbl.text = item.percentageFormat
            
        }
}
