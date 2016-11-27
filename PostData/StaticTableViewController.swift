//
//  StaticTableViewController.swift
//  PostData
//
//  Created by 李小明 on 2016/11/24.
//  Copyright © 2016年 李小明. All rights reserved.
//

import UIKit

class StaticTableViewController: UITableViewController {
    var data:[[String:String]]!
    var chooseNum:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = [["name":"鋼鐵人","star":"東尼·史塔克"],["name":"金剛狼","star":"休·傑克曼"],["name":"雷神索爾","star":"克里斯·漢斯沃"]]
        let notificationName = Notification.Name("AddMovieNoti")
        
        NotificationCenter.default.addObserver(self, selector:
            #selector(StaticTableViewController.addMovieNoti(noti:)), name:
            notificationName, object: nil)
        let notificationData = Notification.Name("GetUpdateNoti")
        NotificationCenter.default.addObserver(self, selector:
            #selector(InterducePageViewController.getUpdateNoti(noti:)), name: notificationData,object:nil)
        let notificationChoosenum = Notification.Name("GetUpdateNoti2")
        NotificationCenter.default.addObserver(self, selector:
            #selector(InterducePageViewController.getUpdateNoti2(noti:)),name: notificationChoosenum,object: nil)
        
        let fileManager = FileManager.default
        let docUrls =
            
            fileManager.urls(for: .documentDirectory, in:
                .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("電影英雄.txt")
        let loadData = NSArray(contentsOf: url!) as! [[String : String]]!
        if loadData != nil{
            data = loadData
                    }
        
                // Do any additional setup after loading the view.
    }
     func writeData(){
        let fileManager = FileManager.default
        let docUrls =
            
            fileManager.urls(for: .documentDirectory, in:
                .userDomainMask)
        let docUrl = docUrls.first
        let url =  docUrl?.appendingPathComponent("電影英雄.txt")
        (data as NSArray).write(to: url!, atomically:
            true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let name = sender as! Dictionary
        if segue.identifier == "InterducePageViewController"{
        let controller = segue.destination as!
        InterducePageViewController
        controller.data = data
        controller.chooseNum = chooseNum
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addMovieNoti(noti:Notification) {
       /* let movieDic = noti.userInfo as! [String:String]
        self.movieArray.insert(movieDic, at: 0)
        self.tableview.reloadData() */
        let movieDic = noti.userInfo as!
            [String:String]
        self.data.insert(movieDic, at: 0)
        let indexPath = IndexPath(row: 0, section:0)
        self.tableView.insertRows(at:[indexPath],with: UITableViewRowAnimation.automatic)
        writeData()
    }
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =
            tableView.dequeueReusableCell(withIdentifier:"CellId",
                                          for: indexPath)
        let dic = self.data[indexPath.row]
        cell.textLabel?.text = dic["name"]
        cell.accessoryType =
            UITableViewCellAccessoryType.disclosureIndicator
        return cell
        
    }
    override func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        
        chooseNum = indexPath.row
        self.performSegue(withIdentifier: "InterducePageViewController", sender: data )
 
    }
    func getUpdateNoti(noti:Notification) {
        
        data = noti.userInfo!["data"] as! [Dictionary<String, String>]!
        //nameLabel.text = data[0]["name"]
        
    }
    func getUpdateNoti2(noti:Notification) {
        
        chooseNum = noti.userInfo!["chooseNum"] as! Int!
        self.tableView.reloadData()
        writeData()
    }
    override func tableView(_ tableView: UITableView, commit
        editingStyle: UITableViewCellEditingStyle, forRowAt
        indexPath: IndexPath) {
        
        self.data.remove(at: indexPath.row)
        tableView.deleteRows(at:[indexPath], with:
            UITableViewRowAnimation.fade)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
