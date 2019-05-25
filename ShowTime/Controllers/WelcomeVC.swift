//
//  WelcomeVC.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 29/04/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import UIKit
import Foundation

class WelcomeVC: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let postData = NSData(data: "{}".data(using: String.Encoding.utf8)!)
        let url = URL(string: "https://api.themoviedb.org/3/authentication/guest_session/new?api_key=1191932350a10cfdd866b164e8b1e95c")!
        var request = URLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
         var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) 
          
        let queryItems = [URLQueryItem(name: "api_key", value: "1191932350a10cfdd866b164e8b1e95c")]
        urlComponents?.queryItems = queryItems
        let session = URLSession.shared
        request.httpMethod = "GET"
        request.httpBody = postData as Data
//        request.addValue("1191932350a10cfdd866b164e8b1e95c", forHTTPHeaderField: "api_key")
        let dataTask = session.dataTask(with: url) { (result) in
            switch result {
            case .success(let response, let data):
                // Handle Data and Response
                let httpResponse = response as? HTTPURLResponse
                print("Here is your free session \(String(describing: httpResponse))")
                print(data)
                break
            case .failure(let error):
                // Handle Error
                print(error)
                break
            }
        }
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async(execute: {
            dataTask.resume()
        })
//        let httpResponse = response as? HTTPURLResponse

    }
    
    
}
