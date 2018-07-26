//
//  EditRecordViewController.swift
//  Baby Feeding
//
//  Created by ArthasFu on 2018/7/19.
//  Copyright © 2018年 ArthasFu. All rights reserved.
//

import UIKit

class EditRecordViewController: UIViewController {
    
    @IBOutlet weak var quantity_textfield: UITextField!
    @IBOutlet weak var selected_datepicker: UIDatePicker!
    
    var edit_data: (String, String, Int)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let timeZone = TimeZone.init(identifier: "UTC+8")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-ddHH:mm"
        
        self.selected_datepicker.setDate(formatter.date(from: (self.edit_data?.0)! + (self.edit_data?.1)!)!, animated: true)
        
        self.quantity_textfield.text = String(format:"%d",(self.edit_data?.2)!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func edit_feed_record_bt_onClick(_ sender: UIButton) {
        if self.quantity_textfield.text?.lengthOfBytes(using: String.Encoding.utf8) == 0 {
            let alertController = UIAlertController(title: "提示", message: "输入奶量", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的",  style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            
            self.performSegue(withIdentifier: "edit_record_done", sender: self)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

