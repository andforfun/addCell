//
//  ViewController.swift
//  PostData
//
//  Created by 李小明 on 2016/11/14.
//  Copyright © 2016年 李小明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var data = [["name":"鋼鐵人","star":"東尼·史塔克"],["name":"金剛狼","star":"休·傑克曼"],["name":"雷神索爾","star":"克里斯·漢斯沃"]]
    
    @IBOutlet weak var name1: UIButton!
    var chooseNum:Int!    
    @IBOutlet weak var name2: UIButton!
    @IBOutlet weak var name3: UIButton!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let name = sender as! Dictionary
        let controller = segue.destination as!
        InterducePageViewController
        controller.data = data
        controller.chooseNum = chooseNum
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationData = Notification.Name("GetUpdateNoti")
        NotificationCenter.default.addObserver(self, selector:
            #selector(InterducePageViewController.getUpdateNoti(noti:)), name: notificationData,object:nil)
        let notificationChoosenum = Notification.Name("GetUpdateNoti2")
        NotificationCenter.default.addObserver(self, selector:
            #selector(InterducePageViewController.getUpdateNoti2(noti:)),name: notificationChoosenum,object: nil)

        // Do any additional setup after loading the view, typically from a nib.
    }
    func getUpdateNoti(noti:Notification) {
        
        data = noti.userInfo!["data"] as! [Dictionary<String, String>]!
        //nameLabel.text = data[0]["name"]
        
    }
    func getUpdateNoti2(noti:Notification) {
        
        chooseNum = noti.userInfo!["chooseNum"] as! Int!
        if chooseNum == 0{
             name1.setTitle(data[chooseNum]["name"]  , for: .normal)  }
        if chooseNum == 1{
            name2.setTitle(data[chooseNum]["name"]  , for: .normal)  }
        if chooseNum == 2{
            name3.setTitle(data[chooseNum]["name"]  , for: .normal)  }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextPageButton(_ sender: Any) {
       /* let controller =
            self.storyboard?.instantiateViewController(withIdentifier:
                "InterducePageViewController") as? InterducePageViewController

                let but = sender as! UIButton
        
        controller?.name = but.currentTitle
        
        self.present(controller!, animated: true, completion: nil) */
        
        let but = sender as! UIButton
        chooseNum = but.tag
        self.performSegue(withIdentifier: "InterducePageViewController", sender: data )
        
        
    }

}

