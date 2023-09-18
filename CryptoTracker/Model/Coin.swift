//
//  Coin.swift
//  CryptoTracker
//
//  Created by Charles Edwards on 9/18/23.
//

import Foundation

struct Coins: Decodable{
    let data: [Coin]
}

struct Coin:Decodable {
    var id: Int
    var name: String
    var symbol: String
    var slug: String
    var num_market_pairs: Double
    var circulating_supply: Double
    var total_supply: Double
    //var max_supply: Double
    var quote :  [String: Quote]
}

struct Quote:Decodable {
    var fully_diluted_market_cap: Double
    var last_updated: String
    var market_cap: Double
    var market_cap_dominance: Double
    var percent_change_1h: Double
    var percent_change_24h: Double
    var percent_change_30d: Double
    var percent_change_60d: Double
    var percent_change_7d: Double
    var percent_change_90d: Double
    var price: Double
    var volume_24h: Double
    var volume_change_24h: Double
}

struct CoinsDetail: Decodable{
    let data: [String : CoinDetail]
}
struct CoinDetail: Decodable{
    var description: String
    
}
 
struct CoinDetailsContainerData {
    var label: String
    var value: Double
    var change: Double? = nil
}
