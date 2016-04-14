//
//  HomeViewController.swift
//  MyDataApp
//
//  Created by Seong Hoon Jeong on 2016. 1. 10..
//  Copyright © 2016년 Seong Hoon Jeong. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UITableViewController {
    
    //var myDatas = [MyData]()
    let realm = try! Realm()
    var myDatas = try! Realm().objects(MyData).sorted("name")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDatas.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "UIHomeTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UIHomeTableViewCell
        
        let myData = myDatas[indexPath.row]
        
        cell.nameLabel.text = myData.name
        cell.ratingControl.rating = myData.rating
        
        if (myData.photo_name != "") {
            //let photo = UIImage(named: myData.photo_name)!
            //cell.photoImageView.image = photo
            if let checkedUrl = NSURL(string: myData.photo_name) {
                //cell.photoImageView.image.contentMode = .ScaleAspectFit
                downloadImage(cell.photoImageView, url: checkedUrl)
            }
        }
        /*
        else if (myData.photo_url != "") {
            if let checkedUrl = NSURL(string: "http://www.apple.com/euro/ios/ios8/a/generic/images/og.png") {
                //cell.photoImageView.image.contentMode = .ScaleAspectFit
                downloadImage(cell.photoImageView, url: checkedUrl)
            }
        }
        */
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let homeDetailViewController = segue.destinationViewController as! HomeDetailViewController
            
            if let selectedMealCell = sender as? UIHomeTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMyData = myDatas[indexPath.row]
                homeDetailViewController.myData = selectedMyData
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new Data.")
        }
    }

    func downloadImage(photoImageView:UIImageView, url: NSURL){
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                photoImageView.image = UIImage(data: data)
            }
        }
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
}