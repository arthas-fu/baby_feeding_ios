//
//  AddRecordViewController.swift
//  Baby Feeding
//
//  Created by ArthasFu on 2018/7/19.
//  Copyright © 2018年 ArthasFu. All rights reserved.
//

import UIKit

class AddRecordViewController: UIViewController {
    
    @IBOutlet weak var quantity_textfield: UITextField!
    @IBOutlet weak var now_datepicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func add_feed_record_bt_onClick(_ sender: UIButton) {
        if self.quantity_textfield.text?.lengthOfBytes(using: String.Encoding.utf8) == 0 {
            let alertController = UIAlertController(title: "提示", message: "输入奶量", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的",  style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            
            self.performSegue(withIdentifier: "add_record_done", sender: nil)
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func cancel_bt(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
    

}

