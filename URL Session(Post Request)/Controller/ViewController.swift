//
//  ViewController.swift
//  URL Session(Post Request)
//
//  Created by Adwait Barkale on 30/10/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit

//https://jsonplaceholder.typicode.com/posts
class ViewController: UIViewController {
    
    @IBOutlet weak var txtUserID: UITextField!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtBody: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //URL Session
        //hitGetRequest()
        hitPostRequest()
        //Alamofire
        //hitGetRequestAF()
        //hitPostRequestAF()
    }
    
    
    func hitGetRequest()
    {
        DataHelper1().sendRequest(url: "https://jsonplaceholder.typicode.com/posts") { (data, success) in
            if success{
                let arrDataModel = data as! [DataModel]
                if let ID = arrDataModel[1].id{
                    print(ID)
                }
            }else{
                print("Data Not Received")
            }
        }
    }
    
    func hitGetRequestAF()
    {
        DataHelper1().sendRequestAF(url: "https://jsonplaceholder.typicode.com/posts") { (data, success) in
            if success{
                let arrDataModel = data as! [DataModel]
                if let ID = arrDataModel[1].id{
                    print(ID)
                }
            }else{
                print("Data Not Received")
            }
        }
    }
    
    func hitPostRequest()
    {
        let parameters: [String: Any] = [
            "userId": "10",
            "title": "Adwait",
            "body": "This is Body"
        ]
        DataHelper2().sendPostRequest(url: "https://jsonplaceholder.typicode.com/posts", parameters: parameters) { (data, success) in
            if success{
                let objDataModel2 = data as! DataModel2
                    if let body = objDataModel2.body {
                        print(body)
                    }
            }
            
        }
    }
    
    func hitPostRequestAF()
    {
        let parameters: [String: Any] = [
            "userId": "10",
            "title": "Adwait",
            "body": "This is Body"
        ]
        DataHelper2().sendPostRequestAF(url: "https://jsonplaceholder.typicode.com/posts", parameters: parameters) { (data, success) in
            if success{
                let objDataModel2 = data as! DataModel2
                    if let body = objDataModel2.body {
                        print(body)
                    }
            }
        }
    }

    
    @IBAction func btnPostRequestTapped(_ sender: UIButton) {
        //setupPostMethod()
    }
    
    
    
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

// func setupPostMethod()
//    {
//        //Check whether Data is present
//        guard let uid = txtUserID.text else { return }
//        guard let title = txtTitle.text else { return }
//        guard let body = txtBody.text else { return }
//
//        //1.Create URL
//        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts"){
//            //2.Create Request with POST Method
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//            //3.Add Data to parameters
////            let parameters: [String: Any] = [
////                "userId": uid,
////                "title": title,
////                "body": body
////            ]
////            //4.Add Parameters inside request.
////            request.httpBody = parameters.percentEscaped().data(using: .utf8)
//
//            URLSession.shared.dataTask(with: request) { (data, response, error) in
//                guard let data = data else {
//                    if error != nil{
//                        print(error?.localizedDescription ?? "Unknown Error")
//                    }
//                    return
//                }
//
//                if let response = response as? HTTPURLResponse{
//                    guard (200...299) ~= response.statusCode else{
//                        print("Error with Response Code \(response.statusCode)")
//                        print(response)
//                        return
//                    }
//
//                }
//
//                // Data in JSON Format
//                do{
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print("JSONSerialization")
//                    print(json)
//                }catch let err{
//                    print(err.localizedDescription)
//                }
//
//                //Data Decoded from Json to Object(DataModel Wise)
//                do{
//                    let decodedObj = try JSONDecoder().decode([DataModel].self, from: data)
//                    print("Decoding Successful")
//                    print(decodedObj[0].body)
////                    print(decodedObj.id ?? "N/A")
////                    print(decodedObj.userId ?? "N/A")
////                    print(decodedObj.title ?? "N/A")
////                    print(decodedObj.body ?? "N/A")
//                }catch let err{
//                    print("Error Decoding \(err.localizedDescription)")
//                }
//            }.resume()
//        }
//    }
