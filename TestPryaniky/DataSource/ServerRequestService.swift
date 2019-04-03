//
//  ServerRequestService.swift
//  TestPryaniky
//
//  Created by Vladislav on 04/04/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import Foundation

class ServerRequestService {
    
    private var defaultURL = "https://prnk.blob.core.windows.net/tmp/JSONSample.json"
    
    func getData(from url: String? = nil) {
        guard let url = URL(string: defaultURL) else {
            print("Url is not found")
            return
        }
        
        let defaultHeaders = [
            "Content-Type" : "application/json"
        ]
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = defaultHeaders
        request.httpMethod = "POST"
        
        let requestGroup = DispatchGroup()
        requestGroup.enter()
        let dataTask = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("http response: \(httpResponse)")
            }
            
            guard let data = data else {
                print("no data received")
                requestGroup.leave()
                return
            }
        }
        
        dataTask.resume()
        requestGroup.wait()
    }
    
}
