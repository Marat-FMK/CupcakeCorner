//
//  CheckOutView.swift
//  CupcakeCorner
//
//  Created by Marat Fakhrizhanov on 10.10.2024.
//

import SwiftUI

struct CheckOutView: View {
    var order: Order
    
    @State private var confirmationMassage = ""
    @State private var showingConfirmation = false
    
    @State private var showError = false
    @State private var errorMessage = "Dont POST request"
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total cost is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you", isPresented: $showingConfirmation ){
            Button("OK") {}
        } message: {
            Text(confirmationMassage)
        }
        .alert("Error", isPresented: $showError) {
            Button("Oyyyyy") {}
        } message: {
            Text(errorMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "http://reqres.in/api/rew")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data,_) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMassage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way !"
            showingConfirmation = true
        } catch {
            print("Check out failed \(error.localizedDescription)")
            showError = true
            errorMessage = "Sorry ^ error in network"
        }
        
    }
    
    
}

#Preview {
    CheckOutView(order: Order())
}
