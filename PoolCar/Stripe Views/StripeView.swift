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
    // swiftlint:disable:next weak_delegate
    private var paymentContextDelegate = PaymentContextDelegate()
    private var context: STPPaymentContext

    // TODO figure out how to handle errors and passing from delegate to struct
    private class PaymentContextDelegate: NSObject, STPPaymentContextDelegate {
        func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {}

        func paymentContextDidChange(_ paymentContext: STPPaymentContext) {}

        func paymentContext(_ paymentContext: STPPaymentContext,
                            didCreatePaymentResult paymentResult: STPPaymentResult,
                            completion: @escaping STPPaymentStatusBlock) {
            StripeAPIClient().createPaymentIntent(price: 20,
                                                  paymentContext: paymentContext,
                                                  paymentResult: paymentResult, completion: completion)
        }

        func paymentContext(_ paymentContext: STPPaymentContext,
                            didFinishWith status: STPPaymentStatus, error: Error?) {}
    }

    var body: some View {
        VStack {
            Button(action: {
                self.context.presentPaymentOptionsViewController()
            }, label: {
                HStack {
                    Image(systemName: "creditcard")
                        .font(.title)
                    Text("Choose Payment")
                        .fontWeight(.semibold)
                        .font(.title)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(Color.white)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.green, Color.blue]),
                        startPoint: .leading, endPoint: .trailing
                    )
                )
                .cornerRadius(40)
            })

            Button(action: {
                // TODO change for price of ride
                self.context.paymentAmount = 5000
                self.context.requestPayment()
            }, label: {
                HStack {
                    Image(systemName: "car")
                        .font(.title)
                    Text("Reserve Ride")
                        .fontWeight(.semibold)
                        .font(.title)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(Color.white)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.green, Color.blue]),
                        startPoint: .leading, endPoint: .trailing
                    )
                )
                .cornerRadius(40)
            })
        }
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
