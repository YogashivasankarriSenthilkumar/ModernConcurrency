//
//  cartView.swift
//  CombineAndModernConcurrency
//
//  Created by Yogashivasankarri Senthilkumar on 26/05/24.
//

import Foundation
import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        VStack {
            List(cartManager.cartItems, id: \.id) { item in
                VStack(alignment: .leading) {
                    Text(item.product.title)
                        .font(.headline)
                    Text("Quantity: \(item.quantity)")
                        .foregroundColor(.gray)
                }
            }

            Divider()

            VStack(alignment: .trailing) {
                Text("Total Quantity: \(cartManager.cartItems.reduce(0, { $0 + $1.quantity }))")
                    .font(.headline)
                Text(String(format: "Total Amount: $%.2f", cartManager.getTotalAmount()))
                    .font(.headline)
            }
            .padding()

            Spacer()
        }
        .navigationBarTitle("Cart")
//        .onAppear {
//            print("cart items \(cartManager.cartItems)")
//            cartManager.printIndividualAmounts()
//        }
    }
}


#Preview {
    let cartManager = CartManager()
    cartManager.cartItems = []

    return ProductListView()
        .environmentObject(cartManager) 
}
