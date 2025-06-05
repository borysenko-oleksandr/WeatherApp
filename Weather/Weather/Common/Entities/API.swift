//
//  APIServcie.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 29.01.2025.
//

import Foundation

enum Methods: String {
    case Get = "Get"
    case Post = "Post"
}

enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
}
