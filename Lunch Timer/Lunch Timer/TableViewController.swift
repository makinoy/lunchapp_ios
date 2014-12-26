//
//  ViewController.swift
//  Lunch Timer
//
//  Created by makinoy on 10/18/14.
//  Copyright (c) 2014 makinoy. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet var profileView : FBProfilePictureView?

    var user: FBGraphUser?
    var items: NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.profileView!.profileID = user!.objectID

        let accessToken = FBSession.activeSession().accessTokenData.accessToken!
        let url = "http://www.tejitak.com/lunch/api/groups?inputToken=" + accessToken
        let request = NSURLRequest(URL:NSURL(string:url)!)
        let error = NSErrorPointer()

        NSURLConnection.sendAsynchronousRequest(request,
            queue: NSOperationQueue.mainQueue(),
            completionHandler: self.fetchResponse)
    }

    func fetchResponse(res: NSURLResponse!, data: NSData!, error: NSError!) {

        let json:NSArray = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.allZeros, error: nil) as NSArray

        var element:NSDictionary = json[0] as NSDictionary

        println(element)

        self.title = element["name"] as? String
        items = element["shops"] as NSArray

        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:TableViewCell? = tableView.dequeueReusableCellWithIdentifier("default-cell") as TableViewCell?
        if cell == nil {
            cell = TableViewCell(style:.Default, reuseIdentifier: "default-cell")
            cell?.shopImageView = UIImageView()
        }

        var element:NSDictionary = items[indexPath.row] as NSDictionary
        cell?.mainLabel?.text = element["name"] as? String
//        cell?.detailTextLabel?.text = element["category"] as? String

        var q_global: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        var q_main: dispatch_queue_t  = dispatch_get_main_queue();

        dispatch_async(q_global, {

            var url : NSURL! = NSURL(string: (element["imageURL"] as String))
            var data : NSData? = NSData(contentsOfURL: url);
            if data != nil {
                var image : UIImage? = UIImage(data: data!)
                dispatch_async(q_main, {
                    cell?.shopImageView!.image = image;
                    cell?.layoutSubviews()
                })
            }
        })

        return cell!
    }
}

