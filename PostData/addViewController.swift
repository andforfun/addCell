//
//  addViewController.swift
//  PostData
//
//  Created by 李小明 on 2016/11/24.
//  Copyright © 2016年 李小明. All rights reserved.
//

import UIKit

class addViewController: UIViewController {
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var star: UITextField!
    @IBAction func doneButton(_ sender: AnyObject) {
        let dic =
            ["name":self.name.text!,
             
             "star":self.star.text!]
        let notificationName =
            Notification.Name("AddMovieNoti")
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: dic)
            
        
        self.navigationController?.popViewController(animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
