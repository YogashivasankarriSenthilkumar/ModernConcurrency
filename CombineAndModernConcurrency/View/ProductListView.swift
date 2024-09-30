//
//  TodoListView.swift
//  CombineAndModernConcurrency
//
//  Created by Yogashivasankarri Senthilkumar on 21/05/24.

import Foundation
import SwiftUI
import Combine

struct ProductListView: View {
    @ObservedObject var viewModel = ProductViewModel()
    @ObservedObject var model = ProductModel()
    @StateObject var selectedProduct =  productData()
    @EnvironmentObject var cartManager: CartManager
    @State private var cartItemCount: Int = 0

    var body: some View {
        NavigationView {
            NavigationLink(destination: ProductDetailView(product: selectedProduct, cartItemCount: $cartItemCount)){
                List(viewModel.products, id: \.id) { product in
                    HStack {
                        URLImage(url: product.image)
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("$\(product.price)")
                                .foregroundColor(.gray)
                        }
                    }.onTapGesture {
                        selectedProduct.id = product.id
                        selectedProduct.title = product.title
                        selectedProduct.description = product.description
                        selectedProduct.image = product.image
                        selectedProduct.price = product.price
                        print("Item Tapped")
                    }
                }
            }
           // MARK: Using Combine
            .onAppear {
                viewModel.fetchTodos()
            }
            //MARK: Using Async Await
//            .task {
//                await model.fetchTodos()
//            }
            .navigationBarTitle("Products")
            .navigationBarItems(trailing:
                                    NavigationLink(destination: CartView()) {
                HStack {
                    Image(systemName: "cart")
                        .font(.title)
                        .foregroundColor(.blue)
                    Text("\(cartItemCount)")
                        .foregroundColor(.blue)
                }
            }
            )
        }
    }
}

struct URLImage: View {
    let url: String
    @State private var image: UIImage?

    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
        } else {
            Color.gray
                .onAppear(perform: loadImage)
        }
    }

    private func loadImage() {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        let cartManager = CartManager()
        cartManager.cartItems = []
        return ProductListView()
            .environmentObject(cartManager) 
    }
}

