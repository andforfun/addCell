//
//  InterducePageViewController.swift
//  PostData
//
//  Created by 李小明 on 2016/11/14.
//  Copyright © 2016年 李小明. All rights reserved.
//

import UIKit

class InterducePageViewController: UIViewController {


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    var data1:[Dictionary<String, String>]!
    var name:String!
    var star:String!
    var data:[Dictionary<String, String>]!
    var chooseNum:Int!
    var chooseNum2:Int!
    
    @IBOutlet weak var Image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationData = Notification.Name("GetUpdateNoti")
        NotificationCenter.default.addObserver(self, selector:
         #selector(InterducePageViewController.getUpdateNoti(noti:)), name: notificationData,object:nil)
         let notificationChoosenum = Notification.Name("GetUpdateNoti2")
        NotificationCenter.default.addObserver(self, selector:
        #selector(InterducePageViewController.getUpdateNoti2(noti:)),name: notificationChoosenum,object: nil)
        nameLabel.text = data[chooseNum]["name"]
        starLabel.text = data[chooseNum]["star"]
        let  imageView:UIImage
        if chooseNum == 0 {
            imageView = UIImage(named: "鋼鐵人")!
        }
        else if chooseNum == 1{
             imageView = UIImage(named: "金剛狼")!
        }
        else{
             imageView = UIImage(named: "雷神索爾")!
        }
        Image.image = imageView
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let name = sender as! Dictionary
        let controller = segue.destination as!
        EditViewController
        controller.data = data
        controller.chooseNum = chooseNum
    }

        func getUpdateNoti(noti:Notification) {
        
         data = noti.userInfo!["data"] as! [Dictionary<String, String>]!
         //nameLabel.text = data[0]["name"]
           
    }
    func getUpdateNoti2(noti:Notification) {
        
        chooseNum = noti.userInfo!["chooseNum"] as! Int!
        nameLabel.text = data[chooseNum]["name"]
        starLabel.text = data[chooseNum]["star"]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func EditButton(_ sender: AnyObject) {
      /*  let controller =
            self.storyboard?.instantiateViewController(withIdentifier:
                 "EditViewController") as?
        EditViewController */
        //let but = sender as! UIButton
        
        //controller?.data = data1
        //controller?.chooseNum = 123
        //self.navigationController?.pushViewController(controller!, animated: true)
         self.performSegue(withIdentifier: "InterducePageViewController", sender: data )
        
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
