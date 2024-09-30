//
//  ToDoService.swift
//  CombineAndModernConcurrency
//
//  Created by Yogashivasankarri Senthilkumar on 21/05/24.
//

import Foundation
import Combine

//MARK: Using Combine
class ProductService {
    private let baseURL = URL(string: "https://fakestoreapi.com/products")!

    func fetchProducts() -> AnyPublisher<[Products], Error> {
        URLSession.shared.dataTaskPublisher(for: baseURL)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Products].self, decoder: JSONDecoder())
            .mapError { error -> Error in
                print("Error\(error)")
                return error
            }
            .eraseToAnyPublisher()
    }
}


//MARK: Using Async Await
class ProductServiceusingAsync {
    private let baseURL = URL(string: "https://fakestoreapi.com/products")!

    func fetchProduct() async throws -> [Products] {
        let (data, response) = try await URLSession.shared.data(from: baseURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        do {
            let todos = try JSONDecoder().decode([Products].self, from: data)
            return todos
        } catch {
            throw error
        }
    }
}
