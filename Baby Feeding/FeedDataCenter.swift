//
//  FeedDataCenter.swift
//  Baby Feeding
//
//  Created by ArthasFu on 2018/7/21.
//  Copyright © 2018年 ArthasFu. All rights reserved.
//

import UIKit

class FeedDataCenter{
    
    private var feed_data_array = Array<(String, String ,Int)>()
    private var record_by_day_array = Array<(String, Int)>()
    private var record_by_hour_array: Array<(String, String, Int, Int)> = [
        ("00:00", "01:00", 0, 0),
        ("01:00", "02:00", 0, 0),
        ("02:00", "03:00", 0, 0),
        ("03:00", "04:00", 0, 0),
        ("04:00", "05:00", 0, 0),
        ("05:00", "06:00", 0, 0),
        ("06:00", "07:00", 0, 0),
        ("07:00", "08:00", 0, 0),
        ("08:00", "09:00", 0, 0),
        ("09:00", "10:00", 0, 0),
        ("10:00", "11:00", 0, 0),
        ("11:00", "12:00", 0, 0),
        ("12:00", "13:00", 0, 0),
        ("13:00", "14:00", 0, 0),
        ("14:00", "15:00", 0, 0),
        ("15:00", "16:00", 0, 0),
        ("16:00", "17:00", 0, 0),
        ("17:00", "18:00", 0, 0),
        ("18:00", "19:00", 0, 0),
        ("19:00", "20:00", 0, 0),
        ("20:00", "21:00", 0, 0),
        ("21:00", "22:00", 0, 0),
        ("22:00", "23:00", 0, 0),
        ("23:00", "24:00", 0, 0),
    ]
    private let fm = FileManager.default
    private let filePath = NSHomeDirectory() + "/Documents/feeding_record"

    func FeedDataCenter(){
    }

    func initData(){
        
        let exist = self.fm.fileExists(atPath: self.filePath)
        if !exist {
            self.fm.createFile(atPath: self.filePath, contents:nil,attributes:nil)

            return
        }
        
        let readHandler = FileHandle(forReadingAtPath: self.filePath)
        let data = readHandler?.readDataToEndOfFile()
        let readString = String(data: data!, encoding: String.Encoding.utf8)
        let subStr = readString?.components(separatedBy: ",")
        //subStr?.removeLast()
        
        for element in subStr!{
            let subElement = element.components(separatedBy: " ")
            if(3 != subElement.count){
                continue
            }
            self.feed_data_array.append((subElement[0], subElement[1], Int(subElement[2])!))
        }
        
        //self.feed_data_array.sort(by: self.sort)
        
    }
    
    private func sort(a: (String, String, Int), b: (String, String, Int)) -> Bool{
        if a.0 + a.1 >= b.0 + b.1 {
            return true
        }
        else {
            return false
        }
    }
    
    func get_data_count() -> Int{
        return self.feed_data_array.count
    }
    
    func get_selected_data(selected_row: Int) -> (String, String, Int){
        return self.feed_data_array[selected_row]
    }
    
    func add_data(data: (String, String, Int)){
        self.feed_data_array.insert(data, at: 0)
        
        self.feed_data_array.sort(by: self.sort)
        
        self.save_data_file()
    }
    
    func update_data(data: (String, String, Int), index: Int){
        self.feed_data_array.remove(at: index)
        self.feed_data_array.append(data)
        
        self.feed_data_array.sort(by: self.sort)
        
        self.save_data_file()
    }
    
    func remove_data(index: Int){
        self.feed_data_array.remove(at: index)
        
        self.save_data_file()
    }
    
    func save_data_file(){
        let writeHandler = FileHandle(forWritingAtPath: self.filePath)
        
        var string: String = ""
        
        for element in self.feed_data_array{
            string += (element.0 + " ")
            string += (element.1 + " ")
            string += String(element.2)
            string += ","
        }
        let data = string.data(using: String.Encoding.utf8)
        writeHandler?.write(data!)
        
        writeHandler?.closeFile()
    }
    
    func get_record_by_day() -> (Array<(String, Int)>){
        self.record_by_day_array.removeAll()
        
        for element in self.feed_data_array{
            var found = false
            for (i, var item) in self.record_by_day_array.enumerated(){
                if item.0 == element.0{
                    item.1 += element.2
                    found = true
                    self.record_by_day_array[i].1 = item.1
                    break;
                }
            }
            if(false == found){
                self.record_by_day_array.append((element.0, element.2))
            }
        }
        
        return self.record_by_day_array;
    }
    
    
    func get_record_by_hour() -> (Array<(String, String, Int, Int)>){
        for i in 0..<self.record_by_hour_array.count{
            self.record_by_hour_array[i].2 = 0
            self.record_by_hour_array[i].3 = 0
        }
        
        for element in self.feed_data_array{
            var subStr = element.1.components(separatedBy: ":")
            let hour = subStr[0]
            let h = Int(hour)
            
            self.record_by_hour_array[h!].2 += element.2
            self.record_by_hour_array[h!].3 += 1
        }
        
        return self.record_by_hour_array;
    }
}
