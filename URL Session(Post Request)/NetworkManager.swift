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
                    completion([],false)
                }else{
                    if let safeData = data{
                        print(safeData)
                        completion(safeData,true)
                    }
                }
            }.resume()
        }
    }
    
    func performGetRequestAF(with url:String,completion:@escaping(_ response:Any,_ success:Bool)->Void)
    {
        if let url = URL(string: url){
            AF.request(url).response { response in
                switch response.result {
                case .success(let data):
                    print("Success Alamofire")
                    if let safeData = data{
                        //print(safeData)
                        completion(safeData,true)
                    }
                case .failure(let err):
                    print("Alamofire Error after hiting Request \(err.localizedDescription)")
                        completion([],false)
                }
            } // Closure end
        } //If Url end
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
    
    func performPostRequestAF(with url:String,parameters:[String:Any?],completion:@escaping(_ response:Any,_ success:Bool)->Void )
    {
        if let url = URL(string: url){
            AF.request(url,method: .post,parameters: parameters as Parameters).response { response in
                switch response.result{
                case .success(let data):
                    print("Alamofire Success POST")
                    if let safeData = data{
                        completion(safeData,true)
                    }
                case .failure(let err):
                    print("Almofire error Post \(err.localizedDescription)")
                    completion([],false)
                }//end of switch
            }
        }
    }
}
