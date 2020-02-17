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
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let relPath = "/users/ephemeralKey/" + UserIDUtils.getUserID()
        let params = ["version": apiVersion]
        let baseURL = "http://localhost:5000/"
        
        var components = URLComponents(string: NSString.path(withComponents: [baseURL, relPath]))
        components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value) }
        let finalURL = components?.url?.absoluteString ?? ""
        //APIFetcher.getJSONResponse(url, params: params, completion: completion)
        AF.request(finalURL, method: .get)
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

    //    func createCustomerKey(withAPIVersion apiVersion: String,
    //                           completion: @escaping STPJSONResponseCompletionBlock) {
    //        let baseURL = "http://localhost:5000/users/key"
    //        AF.request(baseURL, method: .get)
    //        .validate(statusCode: 200..<300)
    //        .responseJSON { responseJSON in
    //            switch responseJSON.result {
    //            case .success(let json):
    //                completion(json as? [String: AnyObject], nil)
    //            case .failure(let error):
    //                completion(nil, error)
    //            }
    //        }
    //    }

    func createPaymentIntent(ride: Ride,
                             paymentContext: STPPaymentContext,
                             paymentResult: STPPaymentResult,
                             completion: @escaping STPPaymentStatusBlock) {
        let url = "/rides/purchase/\(ride.id)"
        let req = UserRequest(userID: UserIDUtils.getUserID())
        APIFetcher.postJSONResponse(url,
                                    params: req) { (resp: StripeClientSecretResponse?, err: APIError?) in
            guard let clientSecret = resp else {
                completion(.error, err)
                return
            }

            let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret.secret)
            paymentIntentParams.paymentMethodId = paymentResult.paymentMethod?.stripeId

            STPPaymentHandler.shared()
            .confirmPayment(withParams: paymentIntentParams,
                            authenticationContext: paymentContext) { status, _, error in
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
        }
    }

    //    func createPaymentIntent(price: Double,
    //                             paymentContext: STPPaymentContext, paymentResult: STPPaymentResult,
    //                             completion: @escaping STPPaymentStatusBlock) {
    //        let baseURL = "http://localhost:5000/users/charge"
    //        AF.request(baseURL, method: .post)
    //        .validate(statusCode: 200..<300)
    //        .responseJSON { responseJSON in
    //            switch responseJSON.result {
    //            case .success(let resp):
    //                guard let clientSecret = resp as? StripeClientSecretResponse else {
    //                    completion(.error, APIError.castError(type: StripeClientSecretResponse.self))
    //                    break
    //                }
    //
    //                let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret.secret)
    //                paymentIntentParams.paymentMethodId = paymentResult.paymentMethod?.stripeId
    //
    //                STPPaymentHandler.shared()
    //                    .confirmPayment(withParams: paymentIntentParams,
    //                                    authenticationContext: paymentContext) { status, _, error in
    //                    switch status {
    //                    case .succeeded:
    //                        completion(.success, nil)
    //                    case .failed:
    //                        completion(.error, error)
    //                    case .canceled:
    //                        completion(.userCancellation, nil)
    //                    @unknown default:
    //                        completion(.error, nil)
    //                    }
    //                }
    //            case .failure(let error):
    //                completion(.error, error)
    //            }
    //        }
    //    }
    //}
}
