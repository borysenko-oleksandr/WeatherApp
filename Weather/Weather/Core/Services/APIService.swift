//
//  File.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 29.01.2025.
//

import Foundation


class APIService {
    static let shared = APIService()
    
    private init() {}
    
    func httpRequest<T: Decodable>(
        urlString: String,
        methods: Methods,
        body: Data? = nil,
        responseType: T.Type
    ) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        
        request.httpMethod = methods.rawValue
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.requestFailed
        }

        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            debugPrint("Decoding Error:", error)
            throw APIError.decodingFailed
        }
    }
}
