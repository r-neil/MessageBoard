//
//  APIHelper.swift
//  MB-iOS-App
//
//  Created by Neil on 9/29/16.
//  Copyright © 2016 Neil. All rights reserved.
//

import Foundation

protocol MessageDataDelegate {
    func messageDataReturned(messageArray:NSArray)
    func deleteSucessfulReload()
}

class APIHelper{

    private var dataAPIURL : URL{
        get{
            return URL(string: "http://localhost:8000/api/show_messages")!
        }
    }
    
    var delegate : MessageDataDelegate?
    
    
    init(){
        performDataFetch()
    }
    
    // MARK: - POST Message to Server
    
    func postMessageWith(content:String, author:String){
        var request = URLRequest(url: dataAPIURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        let postString = "{\"content\" : \"\(content)\", \"author\" : \"\(author)\"}"
        request.httpBody = postString.data(using: .utf8)
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 201 {
                print("Error with POST")
                print("statusCode should be 201, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                print("Post Sucessful!")
            }
            let responseString = String(data: data!, encoding: .utf8)
            print("POST")
            print("responseString = \(responseString!)")
        }
        task.resume()
    }
    
    // MARK: - DELETE Message from Server
    func deleteMessageWith(id:Int){
        var request = URLRequest(url: dataAPIURL)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        let postString = "{\"message_id\":\(id)}"
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("Error with DELETE")
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                print("Delete Sucessful!")
                self.delegate?.deleteSucessfulReload()
            }
            let responseString = String(data: data!, encoding: .utf8)
            print("DELETE")
            print("responseString = \(responseString!)")
        }
        task.resume()
    }
    
    // MARK: - Fetch Message from Server
    private func performDataFetch(){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: dataAPIURL) { (data, response, error) in
            do {
                if let messageDataArray = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                {
                    self.sendDataToDelegate(messageArray: messageDataArray)
                }
            } catch {
                print("error in JSONSerialization")
            }
        }
        task.resume()
    }
    
    private func sendDataToDelegate(messageArray:NSArray){
        DispatchQueue.main.async {
            self.delegate?.messageDataReturned(messageArray: messageArray)
        }
    }
    
}
