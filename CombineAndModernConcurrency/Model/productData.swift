//
//  productData.swift
//  CombineAndModernConcurrency
//
//  Created by Yogashivasankarri Senthilkumar on 26/05/24.
//

import Foundation
import Combine

// Model for the user data to be passed across screens
class productData: ObservableObject {
    @Published var id: Int
    @Published var title: String
    @Published var description: String
    @Published var category: String
    @Published var image: String
    @Published var price: Double

    init(id: Int = 0, title: String = "", description: String = "", category: String = "", image: String = "", price:Double = 0.0) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.image = image
        self.price = price
    }
}

struct CartItem: Identifiable {
    var id = UUID()
    var product: productData
    var quantity: Int
}

//class CartManager: ObservableObject {
//    @Published var cartItems: [CartItem] = []
//
//    func addItemToCart(product: productData) {
//        // Check if the item already exists in cart
//        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
//            // Item exists, update quantity
//            cartItems[index].quantity += 1
//        } else {
//            // Item doesn't exist, add new item to cart
//            cartItems.append(CartItem(product: product, quantity: 1))
//        }
//        objectWillChange.send()
//    }
//
//    func removeItemFromCart(indexSet: IndexSet) {
//        cartItems.remove(atOffsets: indexSet)
//    }
//
//    func getTotalAmount() -> Double {
//        print("value \(cartItems.reduce(0.0) { $0 + Double($1.quantity) * $1.product.price })")
//        return cartItems.reduce(0.0) { $0 + Double($1.quantity) * $1.product.price }
//    }
//
//    func printIndividualAmounts() {
//          for item in cartItems {
//              let amount = Double(item.quantity) * item.product.price
//              print(" titleeee : $\(amount)")
//          }
//          print("Total Amount: $\(getTotalAmount())")
//      }
//}
//


class CartManager: ObservableObject {
    @Published var cartItems: [CartItem] = []

    func addItem(_ product: productData, quantity: Int = 1) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += quantity
        } else {
            let newItem = CartItem(product: product, quantity: quantity)
            cartItems.append(newItem)
        }
    }

    func getTotalAmount() -> Double {
        cartItems.reduce(0) { $0 + $1.product.price * Double($1.quantity) }
    }

    func printIndividualAmounts() {
        for item in cartItems {
            print("\(item.product.title): \(item.product.price * Double(item.quantity))")
        }
    }
}
