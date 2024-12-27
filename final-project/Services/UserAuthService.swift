//
//  UserAuthService.swift
//  final-project
//
//  Created by Алан Абзалханулы on 26.12.2024.
//

import Foundation

struct UserAuthService {
    private let baseURL = "https://reciepts-back-production.up.railway.app/api/v1"
    private let tokenKey = "accessToken"
    
    func register(username: String, email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/register") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["username": username, "email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                return
            }
            
            let message = String(data: data, encoding: .utf8) ?? "Success"
            completion(.success(message))
        }.resume()
    }
    
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("Network Error: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
            }
            
            if let data = data {
                print("Raw Data as Bytes: \(data)")
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let token = json["token"] as? String {
                        completion(.success(token))
                    } else {
                        completion(.failure(NSError(domain: "Invalid Response", code: -2, userInfo: nil)))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    
    func logout() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
    
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.string(forKey: tokenKey) != nil
    }
    func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
}
