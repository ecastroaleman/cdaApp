//
//  APIRequest.swift
//  cda2
//
//  Created by Emilio Castro on 1/9/20.
//  Copyright © 2020 Emilio Castro. All rights reserved.
//

import Foundation

enum APIError:Error{
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct APIRequest {
    let resourceURL: URL
    
    init(endpoint: String){
        let resourceString = "http://ecastro-001-site1.atempurl.com/api/cda/getCambioBus"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func save (_ messageToSave:Message, completion: @escaping(Result<Message, APIError>) -> Void ){
      //  do {
           // let parameters = ["username":"c206","password":"aleman","grant_type":"password"]
                       
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "GET"
      //      guard let httpCuerpo = try? JSONSerialization.data(withJSONObject: parameters, options: [])else{return}
            var queryItems = [URLQueryItem]()
            var components = URLComponents()
            let queryItem = URLQueryItem(name: "username", value: String(describing: "c206"))
            
            queryItems.append(queryItem)
            queryItems.append(URLQueryItem(name: "password", value: "aleman2"))
             queryItems.append(URLQueryItem(name: "grant_type", value: "password"))
            
            urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            components.queryItems = queryItems
            let queryItemData = components.query?.data(using: .utf8)
          //  urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
         //   urlRequest.addValue("\"username\":\"c206\",\"password\":\"aleman\",\"grant_type\":\"aleman\"", forHTTPHeaderField: "Body")
           // print("debug Description --> "+urlRequest.debugDescription)
            //urlRequest.httpBody = try JSONEncoder().encode(messageToSave)
            urlRequest.httpBody = queryItemData
            
            
            let session = URLSession.shared
            session.dataTask(with: urlRequest){(data,response, error)in
                
                DispatchQueue.main.sync {
                    guard let unwrappedResponse = response as? HTTPURLResponse else {
                        completion(.failure(.responseProblem))
                        return
                    }
                    
                    switch unwrappedResponse.statusCode {
                    case 200 ..< 300:
                        print("success")
                    default:
                        print("failure")
                    }
                    
                    if error != nil {
                        completion(.failure(.responseProblem))
                        return
                    }
                    
                    if let unwrappedData = data {
                        do {
                            let json2 = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                            print(json2)
                        }catch{
                            completion(.failure(.responseProblem))
                        }
                    }
                }
                
               // if let response = response {
                    
               // }
               
                 /*   guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                                      let jsonData = data else {
                                          completion(.failure(.responseProblem))
                                          print(response as Any)
                                          print(data.debugDescription)
                                          return
                                  }
                do {
                                 let messageData = try JSONDecoder().decode(Message.self, from: jsonData)
                                 completion(.success(messageData))
                             }catch{
                                 completion(.failure(.decodingProblem))
                             }
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                    }catch{
                        print(error)
                    }
                }*/
                
            }.resume()
            
    /*       let dataTask = URLSession.shared.dataTask(with: urlRequest){data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                    let jsonData = data else {
                        completion(.failure(.responseProblem))
                        print(response as Any)
                        print(data.debugDescription)
                        return
                }
                
                do {
                    let messageData = try JSONDecoder().decode(Message.self, from: jsonData)
                    completion(.success(messageData))
                }catch{
                    completion(.failure(.decodingProblem))
                }
            }
            
            dataTask.resume()*/
     //   }catch{
       //     completion(.failure(.encodingProblem))
        //}
    }
}

