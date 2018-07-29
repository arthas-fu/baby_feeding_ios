//
//  RecordHistoryViewController.swift
//  Baby Feeding
//
//  Created by ArthasFu on 2018/7/19.
//  Copyright © 2018年 ArthasFu. All rights reserved.
//

import UIKit

class RecordHistoryViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {

    var feed_data = FeedDataCenter()
    var selected_row = 0
    
    @IBOutlet weak var history_TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.feed_data.initData()
        self.history_TableView.dataSource = self
        self.history_TableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goto_edit_record"{
            let destination = segue.destination as! EditRecordViewController
            destination.edit_data = self.get_selected_data()
            
        } else if segue.identifier == "goto_record_by_day"{
            let destination = segue.destination as! RecordByDayViewController
            destination.feed_data = self.feed_data.get_record_by_day()
            
        } else if segue.identifier == "goto_record_by_hour"{
            let destination = segue.destination as! RecordByHourViewController
            destination.feed_data = self.feed_data.get_record_by_hour()
    
        }
    
    }

    @IBAction func record_done(segue: UIStoryboardSegue){
        if segue.identifier == "add_record_done"{
            let data = segue.source as! AddRecordViewController
            
            let date_time = data.now_datepicker.date
            let timeZone = TimeZone.init(identifier: "UTC+8")
            let formatter = DateFormatter()
            formatter.timeZone = timeZone
            formatter.locale = Locale.init(identifier: "zh_CN")
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let date_time_str = formatter.string(from: date_time)
            let date_str = date_time_str.components(separatedBy: " ").first!
            let time_str = date_time_str.components(separatedBy: " ").last
            
            let quantity = Int(data.quantity_textfield.text!)
            
            self.feed_data.add_data(data: (date_str, time_str!, quantity!))
            
            self.history_TableView.reloadData()
        } else if segue.identifier == "edit_record_done"{
            let data = segue.source as! EditRecordViewController
            
            let date_time = data.selected_datepicker.date
            let timeZone = TimeZone.init(identifier: "UTC+8")
            let formatter = DateFormatter()
            formatter.timeZone = timeZone
            formatter.locale = Locale.init(identifier: "zh_CN")
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let date_time_str = formatter.string(from: date_time)
            let date_str = date_time_str.components(separatedBy: " ").first!
            let time_str = date_time_str.components(separatedBy: " ").last
            
            let quantity = Int(data.quantity_textfield.text!)
            
            self.feed_data.update_data(data: (date_str, time_str!, quantity!), index: self.selected_row)
            
            self.history_TableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feed_data.get_data_count()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let initIdentifier = "Cell"
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: initIdentifier)
        let cell_data = self.feed_data.get_selected_data(selected_row: indexPath.row)
        
        cell.textLabel?.text = cell_data.0 + "     " + cell_data.1
        cell.detailTextLabel?.text = "\(cell_data.2)" + " ml"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            
            
            self.feed_data.remove_data(index: indexPath.row)
            self.feed_data.save_data_file()
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selected_row = indexPath.row
        self.performSegue(withIdentifier: "goto_edit_record", sender: nil)
    }
    
    func get_selected_data() -> (String, String, Int){
        return self.feed_data.get_selected_data(selected_row: self.selected_row)
    }
}

