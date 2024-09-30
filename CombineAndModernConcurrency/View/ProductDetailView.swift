import Foundation
import SwiftUI

struct ProductDetailView: View {
    let product: productData
    @Environment(\.presentationMode) var presentationMode
    @State private var isOrderConfirmed = false
    @EnvironmentObject var cartManager: CartManager
    @Binding var cartItemCount: Int

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    URLImage(url: product.image)
                        .frame(maxWidth: .infinity, maxHeight: 300) 
                    Spacer(minLength: 10)
                    VStack(alignment: .leading, spacing: 30) {
                        Text("Title")
                            .font(.title2)
                            .foregroundColor(.black)
                        Text(product.title)
                            .font(.title3)
                            .foregroundColor(.indigo)
                        Text("Description")
                            .font(.title3)
                            .foregroundColor(.black)
                        Text(product.description)
                            .foregroundColor(.indigo)
                    }
                    .padding(.horizontal)
                    Spacer()
                    VStack(spacing: 20) {
                        Button(action: { isOrderConfirmed = true }, label: {
                            Text("Buy Now")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.indigo)
                                .clipShape(Capsule())
                        })
                        .padding([.leading, .trailing])

                        Button(action: {  cartManager.addItem(product)
                            cartItemCount += 1 // Update cartItemCount
                            presentationMode.wrappedValue.dismiss()}, label: {
                            Text("Add to Cart")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.yellow)
                                .clipShape(Capsule())
                        })
                        .padding([.leading, .trailing])
                    }
                    .padding(.bottom)
                }
                .padding(.top, 10) // Adjusted spacing for top padding
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                    }
                }
            }
            .onAppear {
                print("product value: \(product.description)")
            }
        }
        .navigationBarHidden(true)
        .background(
            NavigationLink(
                destination: OrderConfirmationView(product: product),
                isActive: $isOrderConfirmed,
                label: {
                    EmptyView()
                }
            )
        )
    }
}

