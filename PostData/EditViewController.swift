//
//  EditViewController.swift
//  PostData
//
//  Created by 李小明 on 2016/11/18.
//  Copyright © 2016年 李小明. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    var data:[Dictionary<String, String>]!
    var chooseNum:Int!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var nickName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
         
        //name.text = "\(chooseNum!)"
        // Do any additional setup after loading the view.
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButtom(_ sender: AnyObject) {
        data[chooseNum]["name"] = name.text
        data[chooseNum]["star"] = nickName.text
        let notificationdata = Notification.Name("GetUpdateNoti")
        NotificationCenter.default.post(name: notificationdata,object: nil, userInfo: ["data":data])
        let notificationChooseNum = Notification.Name("GetUpdateNoti2")
        NotificationCenter.default.post(name: notificationChooseNum,object: nil, userInfo: ["chooseNum":chooseNum])
        //self.dismiss(animated: true, completion: nil)
       // let count = sel
        navigationController?.popViewController(animated: true)
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
