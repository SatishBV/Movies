//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by Satish Bandaru on 14/09/21.
//

import Foundation

final class NetworkManager<T: Codable> {
    static func fetch(from urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  let data = data,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data)
                completion(.success(object))
                return
            } catch {
                completion(.failure(.nilResponse))
                return
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidResponse
    case nilResponse
}
