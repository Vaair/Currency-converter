//
//  TableViewViewModel.swift
//  Конвертер валют
//
//  Created by Лера Тарасенко on 10.03.2021.
//

import Foundation

protocol TableViewViewModelProtocol {
    func count() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModel
    func setSelectedCurrency(forIndexPath indexPath: IndexPath)
    func getSelectedTitle() -> String?
}

class TableViewViewModel: TableViewViewModelProtocol {
    private var currancies: [String]
    private var currentCurrancyTitle: String?
    
    func count() -> Int {
        return currancies.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModel {
        let currency = currancies[indexPath.row]
        return TableViewCellViewModel(currency: currency)
    }
    
    func setSelectedCurrency(forIndexPath indexPath: IndexPath){
        self.currentCurrancyTitle = currancies[indexPath.row]
    }
    
    func getSelectedTitle() -> String? {
        return currentCurrancyTitle
    }
    
    init(dict: NSDictionary){
        let array = dict.allKeys as! [String]
        self.currancies = array.sorted()
    }
}

