//
//  CheckoutView.swift
//  CombineAndModernConcurrency
//
//  Created by Yogashivasankarri Senthilkumar on 26/05/24.
//

import Foundation
import SwiftUI

struct OrderConfirmationView: View {
    let product: productData

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Order Confirmation")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Thank you for your purchase!")
                .font(.title)
                .foregroundColor(.green)

            Text("Order Details: \(product.title)")
                .font(.headline)

            VStack(alignment: .leading, spacing: 10) {
                Text("Order ID: \(product.id)")
                Text("Total Amount: $\(product.price)")
            }

            Spacer()
        }
        .padding()
    }
}
