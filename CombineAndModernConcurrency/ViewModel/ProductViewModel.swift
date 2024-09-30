//
//  TodoViewModel.swift
//  CombineAndModernConcurrency
//
//  Created by Yogashivasankarri Senthilkumar on 21/05/24.
//

import Foundation
import Combine

//MARK: Using Combine
class ProductViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let productService = ProductService()
    @Published var products: [Products] = []
    @Published var errorMessage: String = ""

    func fetchTodos() {
        productService.fetchProducts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion{
                case .finished:
                    print("Success")
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("error")
                }
            }) { products in
                self.products = products
              //  print("Product value: \(products)")
            }
            .store(in: &cancellables)
    }
}


//MARK: Using Async Await
@MainActor
class ProductModel: ObservableObject {
    @Published var products: [Products] = []
    @Published var errorMessage: String? = nil

    func fetchTodos() async {
        do {
            self.products = try await ProductServiceusingAsync().fetchProduct()
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error fetching todos: \(error)")
        }
    }
}
