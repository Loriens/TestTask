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
    
    func getData(from tempURL: String? = nil) -> ViewData? {
        var result: ViewData?
        
        var stringURL: String
        
        if let temp = tempURL {
            stringURL = temp
        } else {
            stringURL = defaultURL
        }
        
        guard let url = URL(string: stringURL) else {
            print("Url is not found")
            return result
        }
        
        let defaultHeaders = [
            "Content-Type" : "application/json"
        ]
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = defaultHeaders
        
        let requestGroup = DispatchGroup()
        requestGroup.enter()
        let dataTask = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print("Http response code: \(httpResponse.statusCode)")
                }
            }
            
            guard let data = data else {
                print("No data received")
                requestGroup.leave()
                return
            }
            
            let decoder = JSONDecoder()
            if let tempViewData = try? decoder.decode(ViewData.self, from: data) {
                result = tempViewData
            }
            requestGroup.leave()
        }
        
        dataTask.resume()
        requestGroup.wait()
        
        return result
    }
    
}
