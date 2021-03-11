//
//  TableViewCellViewModel.swift
//  Конвертер валют
//
//  Created by Лера Тарасенко on 10.03.2021.
//

import Foundation

protocol TableViewCellViewModelProtocol: class {
    var title: String {get}
}

class TableViewCellViewModel: TableViewCellViewModelProtocol {
    private var currency: String
    
    var title: String {
        return currency
    }

    init(currency: String) {
        self.currency = currency
    }
    
}
