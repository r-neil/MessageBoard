//
//  TableModel.swift
//  MB-iOS-App
//
//  Created by Neil on 9/29/16.
//  Copyright © 2016 Neil. All rights reserved.
//

import Foundation

protocol DataReadyDelegate {
    func refreshTable()
}

class TableModel: MessageDataDelegate {
    
    private var messages = [Message]()
    var refreshDelegate: DataReadyDelegate?
    var messageAPI = APIHelper()
    var reloadTimer = Timer()
    
    struct Message {
        var content : String?
        var id : Int?
        var author : String?
    }

    
    init(){
        resetAPIData()
    }
    
    func getCellCount()->Int{
       return messages.count
    }
    
    func getAuthorFor(cellNum:Int)->String{
        return messages[cellNum].author!
    }
    
    func getContentFor(cellNum:Int)->String{
        return messages[cellNum].content!
    }
    
    func deleteCellFor(cellNum:Int){
        let cellToDeleteID = messages[cellNum].id!
        messageAPI.deleteMessageWith(id: cellToDeleteID)
    }
    
    private func resetAPIData(){
        messages = [Message]()
        messageAPI = APIHelper()
        messageAPI.delegate = self
        setupTimer()
    }
    
    private func setupTimer(){
        reloadTimer.invalidate()
        reloadTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (timer) in
            self.resetAPIData()
        })
    }
    
    //Delegate method from MessageDataDelegate
    func messageDataReturned(messageArray: NSArray) {
        for item in messageArray{
            let tempDict = item as! NSDictionary
            var tempMessage = Message()
            tempMessage.content = tempDict.value(forKey: "content") as? String ?? ""
            tempMessage.id = tempDict.value(forKey: "pk") as? Int ?? nil
            tempMessage.author = tempDict.value(forKey: "author") as? String ?? ""
            messages.append(tempMessage)
        }
        self.refreshDelegate?.refreshTable()
    }
    
    func deleteSucessfulReload(){
        DispatchQueue.main.async {
            self.resetAPIData()
        }
    }
}
