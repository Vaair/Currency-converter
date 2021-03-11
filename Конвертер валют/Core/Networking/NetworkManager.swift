//
//  NetworkManager.swift
//  Конвертер валют
//
//  Created by Лера Тарасенко on 10.03.2021.
//

import Foundation

class NetworkManager {

    static func fetchData(url: String, completion: @escaping (_ currencies: Currencies)->()) {

        guard let url = URL(string: url) else { return }
        
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let currencies = Currencies(json: json as! [String : Any]) else {return}
                completion(currencies)
                
            } catch let error {
                print("Error serialization json", error)
            }
            
        }.resume()

    }
 
}
