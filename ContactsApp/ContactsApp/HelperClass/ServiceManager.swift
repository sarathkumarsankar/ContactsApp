//
//  BaseService.swift
//  SampleProject
//
//  Created by Sarathkumar S on 11/07/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import UIKit

typealias successClosure = (_ status: Bool, _ data: Data?) -> Void
typealias failureClosure = (_ status: Bool, _ message: String) -> Void

enum ServiceType: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}

class ServiceManager: NSObject {
    var parameter: [String: Any]?
    
    func callWebService(withURL: String, serviceType: ServiceType!, completionHandler: @escaping successClosure, failureHandler:@escaping failureClosure ) {
        if Reachability.isConnectedToNetwork() {
            let headers = [
              "Connection": "keep-alive",
              "Content-Type": "application/json"
            ]
            let configuration = URLSessionConfiguration.default
            var request = URLRequest(url: URL(string: withURL)!)
            request.httpMethod = serviceType.rawValue
            request.allHTTPHeaderFields = headers
            request.timeoutInterval = 60
            if serviceType == .PUT || serviceType == .POST {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameter as Any, options: .prettyPrinted)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
            session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    failureHandler(false, error.localizedDescription)
                } else if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        completionHandler(true, data)
                    } else {
                        let errorMsg = ErrorModel.checkErrorCode(httpResponse.statusCode)
                        failureHandler(false, errorMsg)
                    }
                }
                }.resume()
        } else {
            failureHandler(false, "Internet Connection not available!")
        }
    }
}

extension ServiceManager: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, urlCredential)
    }
    }
