//
//  Layouts.swift
//  CryptoTracker
//
//  Created by Charles Edwards on 9/18/23.
//

import Foundation
import UIKit

class Layouts {

    static let shared = Layouts()
    
    func coinSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180)), subitems: [item])
        let section = NSCollectionLayoutSection.init(group: group)
        return section
    }
    
}
