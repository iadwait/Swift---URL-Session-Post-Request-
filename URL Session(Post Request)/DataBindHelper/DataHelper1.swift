//
//  DataModelManager.swift
//  URL Session(Post Request)
//
//  Created by Adwait Barkale on 30/10/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import Foundation


class DataHelper1{
    
    public func sendRequest(url: String,completion:@escaping(_ response:[DataModel],_ success:Bool)->Void)
      {
        var arrDataModel:[DataModel] = []
        NetworkManager.shared.performGetRequest(with: url) { (data, success) in
            if success{
                //Bind Data from Json to Swift Object
                do{
                    let objData = try JSONDecoder().decode([DataModel].self, from: data as! Data)
                    print("Decoding Success")
                    arrDataModel = objData
                    completion(arrDataModel,true)
                }catch{
                    print("Error Decoding")
                }
            }else{
                completion(arrDataModel,false)
            }
        }
        
      }
    
}
