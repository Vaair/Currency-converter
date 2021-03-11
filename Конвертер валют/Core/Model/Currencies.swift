//
//  Currencies.swift
//  Конвертер валют
//
//  Created by Лера Тарасенко on 10.03.2021.
//

import Foundation

class Currencies: Codable {
    var rates: [String : Double]
    
    init?(json: [String: Any]){
        rates = json["rates"] as! [String : Double]
    }
}
