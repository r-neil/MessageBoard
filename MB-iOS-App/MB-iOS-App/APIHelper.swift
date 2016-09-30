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
