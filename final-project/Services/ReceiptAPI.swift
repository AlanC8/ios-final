//
//
//  ReceiptAPI.swift
//  final-project
//
//  Created by Алан Абзалханулы on 26.12.2024.
//

import UIKit

class ReceiptAPI {
    func fetchReceipts(from url: String, completion: @escaping ([Receipt]?, Error?) -> Void) {
        guard let requestURL = URL(string: url) else {
            completion(nil, URLError(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { data, _, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, URLError(.badServerResponse))
                return
            }
            
            do {
                let receipts = try JSONDecoder().decode([Receipt].self, from: data)
                completion(receipts, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
