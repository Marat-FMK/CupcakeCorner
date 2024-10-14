//
//  AdressView.swift
//  CupcakeCorner
//
//  Created by Marat Fakhrizhanov on 10.10.2024.
//

import SwiftUI

struct AdressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name ", text: $order.name )
                TextField("Street adressv", text: $order.streetAdress)
                TextField("Cityv", text: $order.city)
                TextField("Zipv", text: $order.zip)
            }
            
            Section {
                NavigationLink(" Check Out ") {
                    CheckOutView(order: order)
                }
            }
            .disabled(false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func checkAdress() -> Bool {
        order.streetAdress.count < 5 ? true : false
    }
    
    private func checkName() -> Bool {
        order.name.isEmpty ? false : true
    }
    
    private func checkCity() -> Bool {
        order.city.isEmpty ? false : true
    }
    
    private func checkZip() -> Bool {
        if order.zip.count == 6 {
                            return true
        }
        return false
    }
}
#Preview {
    AdressView(order: Order())
}
