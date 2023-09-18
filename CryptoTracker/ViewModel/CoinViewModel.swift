//
//  CoinViewModel.swift
//  CryptoTracker
//
//  Created by Charles Edwards on 9/19/23.
//

import Foundation
import Combine

import UIKit

class CoinViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    enum FetchResult{
            case failed(error:Error)
            case success(coins: [Coin])
            case loading(loading: Bool)
        }
    
    private let fetchResult : PassthroughSubject<FetchResult, Never> = .init()
        
    
    func fetchCoins() -> AnyPublisher<FetchResult, Never>{
        APIService.shared.getCoins().sink { [weak self] completion in
                self?.fetchResult.send(.loading(loading: false))
                switch completion {
                case .failure(let error):
                    self?.fetchResult.send(.failed(error: error))
                    print("Error is \(error.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            } receiveValue: { [weak self] coinsData in
                self?.fetchResult.send(.success(coins: coinsData.data))
            }.store(in: &cancellables)
        return fetchResult.eraseToAnyPublisher()
        }
}
