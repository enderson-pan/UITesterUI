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
    static var fileToBeRunning : String?
    
    @IBOutlet weak var headerView: UILabel!
    @IBOutlet weak var footerView: UILabel!
    
    let headerViewPrefix = "将要运行的脚本: "
    
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
        footerView.text = currentPath
        headerView.text = headerViewPrefix
        contentsOfDir = FileInspector.sharedInstance(currentPath).contentsAtPath()
        
        // Don't show the blank cell
        //tableView.tableFooterView = UIView(frame: CGRectZero)
        
        if let fileName = FilelistViewController.fileToBeRunning {
            headerView.text = fileName
        }
        
        // For debug
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
        configureTextForCell(cell, withItem: item)

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        if "Dir" == contentsOfDir[indexPath.row].1 {
            return false
        }
        return true
    }
    

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
    
    // MARK: - TOUCH
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            let item = contentsOfDir[indexPath.row]
            if "File" == item.1 {
                toggleCurrentRunnigFileForCell(cell, withItem: item)
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - HELPER
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as! [String]
        
        return paths[0]
    }
    
    func configureTextForCell(cell: UITableViewCell, withItem item: (String, String)) {
        if "Dir" == item.1 {
            cell.textLabel?.text = item.0
        } else if "File" == item.1 {
            let label = cell.viewWithTag(1000) as! UILabel
            label.text = item.0
        }
    }
    
    func toggleCurrentRunnigFileForCell(cell: UITableViewCell, withItem item: (String, String)) {
        let fullPath = "\(currentPath)/\(item.0)"
        if nil == FilelistViewController.fileToBeRunning {
            FilelistViewController.fileToBeRunning = fullPath
            headerView.text = headerViewPrefix + FilelistViewController.fileToBeRunning!
        } else {
            FilelistViewController.fileToBeRunning = nil
            headerView.text = headerViewPrefix
        }
    }
}
