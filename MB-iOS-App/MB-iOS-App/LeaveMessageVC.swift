//
//  LeaveMessageVC.swift
//  MB-iOS-App
//
//  Created by Neil on 10/12/16.
//  Copyright © 2016 Neil. All rights reserved.
//

import UIKit

class LeaveMessageVC: UIViewController {

    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitBtn() {
        APIHelper().postMessageWith(content: contentTextField.text!, author: authorTextField.text!)
        self.navigationController!.popViewController(animated: true)
    }


}
