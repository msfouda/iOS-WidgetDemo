//
//  Networking.swift
//  WidgetDemo
//
//  Updated by Mohamed Sobhi Fouda on 8/2/18.
//  Created by Hesham Abd-Elmegid on 6/27/16.
//  Copyright © 2016 CareerFoundry. All rights reserved.
//

import Foundation

open class Networking: NSObject {
    
    public typealias CompletionHandler = (_ quote: Quote?, _ error: NSError?) -> ()
    
    open func randomMoviesQuote(_ completion: @escaping CompletionHandler) {
        let apiURL = URL(string: "https://andruxnet-random-famous-quotes.p.mashape.com/?cat=movies")
        var request = URLRequest(url: apiURL!)
        request.httpMethod = "POST"
        request.addValue("70kHu82V9Jmshv3cD2gNkUF915jsp1K0HlYjsnVcns7jvOI4O1", forHTTPHeaderField: "X-Mashape-Key")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data , error == nil else {
                print(error!)
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
                let quote = Quote(quoteDictionary: jsonResponse.first as! [String : String])
                completion(quote, nil)
            } catch {
                print("JSON error: \(error)")
            }
        }
        
        task.resume()
    }
}
