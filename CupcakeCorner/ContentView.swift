//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Marat Fakhrizhanov on 10.10.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var  order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in:  3...20)
                }
                
                Section {
                    Toggle("Any special reguests?", isOn: $order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery details") {
                        AdressView(order: order)
                    }
                }
                
            }
            .navigationTitle("Capcake Corner")
        }
        
    }
    
}

#Preview {
    ContentView()
}
