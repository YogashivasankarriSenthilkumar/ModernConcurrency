//
//  CombineAndModernConcurrencyApp.swift
//  CombineAndModernConcurrency
//
//  Created by Yogashivasankarri Senthilkumar on 21/05/24.
//

import SwiftUI

@main
struct CombineAndModernConcurrencyApp: App {
    @StateObject var cartManager = CartManager()
    var body: some Scene {
        WindowGroup {
            ProductListView()
                .environmentObject(cartManager)
        }
    }
}
