//
//  RecordByDayViewController.swift
//  Baby Feeding
//
//  Created by ArthasFu on 2018/7/29.
//  Copyright © 2018年 ArthasFu. All rights reserved.
//

import UIKit

class RecordByDayViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var feed_data:Array<(String, Int, Int)>? = nil
    
    @IBOutlet weak var history_TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.history_TableView.dataSource = self
        self.history_TableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feed_data!.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let initIdentifier = "Cell"
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: initIdentifier)
        let cell_data = self.feed_data?[indexPath.row]
        
        cell.textLabel?.text = cell_data?.0
        cell.detailTextLabel?.text = "共 \(cell_data?.2 ?? 0) 次 \(cell_data?.1 ?? 0)" + " ml"
        
        return cell
    }
}

