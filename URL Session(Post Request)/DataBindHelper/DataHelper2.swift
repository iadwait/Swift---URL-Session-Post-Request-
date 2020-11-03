//
//  DataHelper2.swift
//  URL Session(Post Request)
//
//  Created by Adwait Barkale on 30/10/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import Foundation


class DataHelper2{
    
    public func sendPostRequest(url: String,parameters:[String:Any?],completion:@escaping(_ response:DataModel2?,_ success:Bool)->Void)
    {
        var objDataModel2:DataModel2? = nil
        NetworkManager.shared.performPostRequest(with: url, parameters: parameters) { (data, success) in
            if success{
                
                do{
                    let decodedObj = try JSONDecoder().decode(DataModel2.self, from: data as! Data)
                    print("Decoding Successful")
                    objDataModel2 = decodedObj
//                    print(decodedObj.id ?? "N/A")
//                    print(decodedObj.userId ?? "N/A")
//                    print(decodedObj.title ?? "N/A")
//                    print(decodedObj.body ?? "N/A")
                    completion(objDataModel2!,true)
                }catch let err{
                    print("Error Decoding \(err.localizedDescription)")
                    completion(objDataModel2!,false) //This is where it fails, i want to pass nothing in the 1st Parameter
                }
            }else{
                print("Data Not Received")
                completion(objDataModel2!,false)//This is where it fails, i want to pass nothing in the 1st Parameter
            }
        }
    }
    
    public func sendPostRequestAF(url: String,parameters:[String:Any?],completion:@escaping(_ response:DataModel2?,_ success:Bool)->Void)
        {
            var objDataModel2:DataModel2? = nil
            NetworkManager.shared.performPostRequestAF(with: url, parameters: parameters) { (data, success) in
                if success{
                    
                    do{
                        let decodedObj = try JSONDecoder().decode(DataModel2.self, from: data as! Data)
                        print("Decoding Successful")
                        objDataModel2 = decodedObj
    //                    print(decodedObj.id ?? "N/A")
    //                    print(decodedObj.userId ?? "N/A")
    //                    print(decodedObj.title ?? "N/A")
    //                    print(decodedObj.body ?? "N/A")
                        completion(objDataModel2!,true)
                    }catch let err{
                        print("Error Decoding \(err.localizedDescription)")
                        completion(objDataModel2!,false) //This is where it fails, i want to pass nothing in the 1st Parameter
                    }
                }else{
                    print("Data Not Received")
                    completion(objDataModel2!,false)//This is where it fails, i want to pass nothing in the 1st Parameter
                }
            }
        }
}
