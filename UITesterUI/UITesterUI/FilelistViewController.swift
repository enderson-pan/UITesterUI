//
//  FilelistViewController.swift
//  UITesterUI
//
//  Created by 潘自强 on 15/8/11.
//  Copyright (c) 2015年 Holytiny. All rights reserved.
//

import UIKit

class FilelistViewController: UITableViewController {
    var currentPath = ""
    var contentsOfDir = [(String, String)]()
    
    @IBOutlet weak var headerView: UILabel!
    
    required init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        currentPath = documentsDirectory()
        contentsOfDir = FileInspector.sharedInstance(currentPath).contentsAtPath()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let showPath = currentPath as NSString
        title = showPath.lastPathComponent
        headerView.text = currentPath
        contentsOfDir = FileInspector.sharedInstance(currentPath).contentsAtPath()
        
        // Don't show the blank cell
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        for (name, type) in contentsOfDir {
            println("\(name) : \(type)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return contentsOfDir.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        let item = contentsOfDir[indexPath.row]
        if "Dir" == item.1 {
            cell = tableView.dequeueReusableCellWithIdentifier("FilelistItemDir", forIndexPath: indexPath) as! UITableViewCell
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("FilelistItemFile", forIndexPath: indexPath) as! UITableViewCell
        }
        
        // Configure the cell...
        cell.textLabel?.text = item.0

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if "ListDir" == segue.identifier {
            let controller = segue.destinationViewController as! FilelistViewController
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                let dir = contentsOfDir[indexPath.row].0
                controller.currentPath = "\(currentPath)/\(dir)"
            }
        }
    }
    
    
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as! [String]
        
        return paths[0]
    }

}