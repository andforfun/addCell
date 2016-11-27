//
//  InterducePageViewController.swift
//  PostData
//
//  Created by 李小明 on 2016/11/14.
//  Copyright © 2016年 李小明. All rights reserved.
//

import UIKit

class InterducePageViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {


    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    var data1:[Dictionary<String, String>]!
    var name:String!
    var star:String!
    var data:[Dictionary<String, String>]!
    var chooseNum:Int!
    var chooseNum2:Int!
    
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
        //let image = loadPicture(name: data[chooseNum]["name"]!)
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory,
                             in: .userDomainMask)
        let docUrl = docUrls.first
        let getNmae = data[chooseNum]["name"]! + ".jpg"
        let url = docUrl?.appendingPathComponent(getNmae)
        let image = UIImage(contentsOfFile: (url?.path)!)
        pictureView.image = image
//Image.image = imageView
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
        writeData()
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
    func loadPicture(name:String)->UIImage{
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory,
                             in: .userDomainMask)
        let docUrl = docUrls.first
        let getNmae = name + ".jpg"
        let url = docUrl?.appendingPathComponent(getNmae)
        let image = UIImage(contentsOfFile: (url?.path)!)
        return image!
    }

    @IBAction func takePicture(_ sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("info \(info)")
        let image = info[UIImagePickerControllerOriginalImage]
        self.pictureView.image = image as? UIImage
        if picker.sourceType == .camera{
        UIImageWriteToSavedPhotosAlbum(self.pictureView.image!, nil, nil, nil)
        }
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory,
                             in: .userDomainMask)
        let docUrl = docUrls.first
        //let interval = Date.timeIntervalSinceReferenceDate
        let getData = self.data[chooseNum]["name"]
        let name = "\(getData!).jpg"
        let url =  docUrl?.appendingPathComponent(name)
        let data = UIImageJPEGRepresentation(image as! UIImage, 0.9)
        try! data?.write(to: url!)
        self.dismiss(animated:true, completion: nil)
    }
   
    @IBAction func usePicture(_ sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
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
