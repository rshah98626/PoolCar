//
//  StripeAPIClient.swift
//  PoolCar
//
//  Created by Rahul Shah on 2/13/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation
import Stripe
import Alamofire

class StripeAPIClient: NSObject, STPCustomerEphemeralKeyProvider {
    func createCustomerKey(withAPIVersion apiVersion: String,
        completion: @escaping STPJSONResponseCompletionBlock) {
        let baseURL = "http://localhost:5000/users/key"
        AF.request(baseURL, method: .get)
        .validate(statusCode: 200..<300)
        .responseJSON { responseJSON in
            switch responseJSON.result {
                case .success(let json):
                    completion(json as? [String: AnyObject], nil)
                case .failure(let error):
                    completion(nil, error)
            }
        }
    }
    
    func createPaymentIntent(price: Double, paymentContext: STPPaymentContext,
        paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        let baseURL = "http://localhost:5000/users/charge"
        AF.request(baseURL, method: .post)
        .validate(statusCode: 200..<300)
        .responseJSON { responseJSON in
            switch responseJSON.result {
                case .success(let resp):
                    let clientSecret = resp as! NSDictionary
                    let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret["secret"] as! String)
                    paymentIntentParams.paymentMethodId = paymentResult.paymentMethod?.stripeId
                    
                    STPPaymentHandler.shared().confirmPayment(withParams: paymentIntentParams, authenticationContext: paymentContext) { status, paymentIntent, error in
                        switch status {
                            case .succeeded:
                                completion(.success, nil)
                            case .failed:
                                completion(.error, error)
                            case .canceled:
                                completion(.userCancellation, nil)
                            @unknown default:
                                completion(.error, nil)
                        }
                    }
                case .failure(let error):
                    completion(.error, error)
                    break
            }
        }
    }
}
