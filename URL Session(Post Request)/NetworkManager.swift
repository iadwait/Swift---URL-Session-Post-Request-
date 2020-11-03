//
//  NetworkManager.swift
//  URL Session(Post Request)
//
//  Created by Adwait Barkale on 30/10/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared:NetworkManager = NetworkManager()
    let parameters: [String:Any?] = [:]
    
    
    //MARK:- Get Request
    func performGetRequest(with url:String,completion:@escaping(_ response:Any,_ success:Bool)->Void )
    {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil{
                    print(error?.localizedDescription ?? "Default Value")
                    completion("No Data",false)
                }else{
                    if let safeData = data{
                        completion(safeData,true)
                    }
                }
            }.resume()
        }
    }
    
    
    //MARK:- Post Request
    func performPostRequest(with url:String,parameters:[String:Any?],completion:@escaping(_ response:Any,_ success:Bool)->Void )
  {
       
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts"){
           
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            request.httpBody = parameters.percentEscaped().data(using: .utf8)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    if error != nil{
                        print(error?.localizedDescription ?? "Unknown Error")
                    }
                    completion("No Data",false)
                    return
                }
                
                if let response = response as? HTTPURLResponse{
                    guard (200...299) ~= response.statusCode else{
                        print("Error with Response Code \(response.statusCode)")
                        print(response)
                        return
                    }
                    
                }
                completion(data,true)

            }.resume()
        }
    }
}
