//
//  ViewModel.swift
//  Конвертер валют
//
//  Created by Лера Тарасенко on 10.03.2021.
//

import Foundation

protocol ViewModelProtocol {
    func getCurrencies() -> NSDictionary
    func getCurrentRate(currency: String) -> Double
    func fetchData()
}

class ViewModel: ViewModelProtocol {
    private let url = "https://open.exchangerate-api.com/v6/latest"
    
    private var currencies: Currencies?
    
    func fetchData() {
        NetworkManager.fetchData(url: self.url) { (currencies)  in
            self.currencies = currencies
        }
    }
    
    func getCurrencies() -> NSDictionary {
        guard let dict = self.currencies?.rates else {return NSDictionary()}
        let nsDict = dict as NSDictionary
        return nsDict
    }
    
    func getCurrentRate(currency: String) -> Double {
        return self.currencies?.rates[currency] ?? 0
    }
    
}
