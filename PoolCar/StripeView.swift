//
//  StripeView.swift
//  PoolCar
//
//  Created by Rahul Shah on 2/13/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import SwiftUI
import Stripe

struct StripeView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    init() {
        let customerContext = STPCustomerContext(keyProvider: StripeAPIClient())
        self.context = STPPaymentContext(customerContext: customerContext)
        self.context.hostViewController = UIApplication.shared.keyWindow?.rootViewController
        self.context.delegate = self.paymentContextDelegate
    }
}

struct StripeView_Previews: PreviewProvider {
    static var previews: some View {
        StripeView()
    }
}
