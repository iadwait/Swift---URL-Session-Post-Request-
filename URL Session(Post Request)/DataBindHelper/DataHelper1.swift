//
//  DataModelManager.swift
//  URL Session(Post Request)
//
//  Created by Adwait Barkale on 30/10/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import Foundation


class DataHelper1{
    
    public func sendRequest(url: String,completion:@escaping(_ response:Array<Any>,_ success:Bool)->Void)
      {
        var arrDataModel:[DataModel] = []
        NetworkManager.shared.performGetRequest(with: url) { (data, success) in
            if success{
                //Bind Data from Json to Swift Object
                do{
                    let objData = try JSONDecoder().decode([DataModel].self, from: data as! Data)
                    print("Decoding Success URL Session")
                    arrDataModel = objData
                    completion(arrDataModel,true)
                }catch{
                    print("Error Decoding URL Session")
                    completion([],false)
                }
            }else{
                completion([],false)
            }
        }
        
      }
    
    public func sendRequestAF(url: String,completion:@escaping(_ response:Array<Any>,_ success:Bool)->Void)
      {
        var arrDataModel:[DataModel] = []
        NetworkManager.shared.performGetRequestAF(with: url) { (data, success) in
            if success{
                //Bind Data from Json to Swift Object
                do{
                    let objData = try JSONDecoder().decode([DataModel].self, from: data as! Data)
                    print("Decoding Success Alamofire")
                    arrDataModel = objData
                    completion(arrDataModel,true)
                }catch{
                    print("Error Decoding Alamofire")
                }
            }else{
                completion([],false)
            }
        }
        
      }
    
}
