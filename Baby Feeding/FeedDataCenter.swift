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
        var subStr = readString?.components(separatedBy: ",")
        subStr?.removeLast()
        
        for element in subStr!{
            let subElement = element.components(separatedBy: " ")
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
}
