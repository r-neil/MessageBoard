//
//  MainTVC.swift
//  MB-iOS-App
//
//  Created by Neil on 9/29/16.
//  Copyright © 2016 Neil. All rights reserved.
//

import UIKit

class MainTVC: UITableViewController, DataReadyDelegate {

    
    let dataSource = TableModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.refreshDelegate = self
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#EBEBE8")
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    @IBAction func addMessageBtn(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "to leave message", sender: self)
    }
    
    // MARK: - TableView Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.getCellCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TVCell
        cell?.authorLabel.text = "~\(dataSource.getAuthorFor(cellNum: indexPath.row))"
        cell?.contentLabel.text = dataSource.getContentFor(cellNum: indexPath.row)
        return cell!
    }
    
    // MARK: - Delegate Methods
    func refreshTable(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Swipe to Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            dataSource.deleteCellFor(cellNum: indexPath.row)
        }
    }
}
