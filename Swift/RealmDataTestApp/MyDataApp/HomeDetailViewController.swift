//
//  HomeDetailViewController.swift
//  MyDataApp
//
//  Created by Seong Hoon Jeong on 2016. 1. 10..
//  Copyright © 2016년 Seong Hoon Jeong. All rights reserved.
//

import UIKit
import RealmSwift

class HomeDetailViewController: UIViewController {
    let realm = try! Realm()
    
    var myData: MyData?
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtImage: UITextField!
    @IBOutlet weak var txtUrl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if myData != nil {
            txtName.text = myData!.name
            txtImage.text = myData!.photo_name
            txtUrl.text = myData!.url
            
            var urlStr = myData!.url
            let range = urlStr.rangeOfString("http")
            
            if range == nil {
                urlStr = "http://" + urlStr
            }
            
            let url = NSURL (string: urlStr)
            let requestObj = NSURLRequest(URL: url!)
        
            webView!.loadRequest(requestObj)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Save" {
            if myData != nil {
                let name = txtName.text!
                let image = txtImage.text!
                let url = txtUrl.text!
                
                try! realm.write {
                    myData!.name = name
                    myData!.photo_name = image
                    myData!.url = url
                }
            } else {
                let myData1 = MyData(value: ["name": txtName.text!, "photo_name": txtImage.text!, "rating": 0, "url": txtUrl.text!])
                
                try! realm.write {
                    realm.add(myData1)
                }
            }
        }
        else if segue.identifier == "Delete" {
            if myData != nil {
                try! realm.write {
                    realm.delete(myData!)
                }
            }
        }
        else if segue.identifier == "Back" {
            print("Back")
        }
    }
}
