//
//  FileInspector.swift
//  UITesterUI
//
//  Created by 潘自强 on 15/8/11.
//  Copyright (c) 2015年 Holytiny. All rights reserved.
//

import Foundation

class FileInspector {
    var parentPath: String?
    var contentsOfPath = [(String, String)]()

    static let sharedInstance_ = FileInspector()
    
    // Singleton
    class func sharedInstance(parentPath: String) -> FileInspector {
        sharedInstance_.parentPath = parentPath
        return sharedInstance_
    }
    
    func contentsAtPath() -> [(String, String)] {
        self.contentsOfPath.removeAll(keepCapacity: true)
        
        var unsortedContents = [String: String]()
        if let path = self.parentPath {
            let contentsOfDir = NSFileManager.defaultManager().contentsOfDirectoryAtPath(path, error: nil)
            if let contents = contentsOfDir {
                for content in contents {
                    let fileName = content as! String
                    let path = "\(self.parentPath!)/\(fileName)"
                    var isDir: ObjCBool = false
                    if NSFileManager.defaultManager().fileExistsAtPath(path, isDirectory: &isDir) {
                        var type: String
                        type = (isDir ? "Dir" : "File")
                        unsortedContents[content as! String] = type
                    }
                }
            }
        }
        
        let tobeSortedContents = sorted(unsortedContents) { a, b in return a.1 < b.1 }
        var i : Int
        for i = 0; i < tobeSortedContents.count; ++i {
            if "File" == tobeSortedContents[i].1 {
                break
            }
        }
        let dirContents = tobeSortedContents[0..<i]
        let fileContents = tobeSortedContents[i..<tobeSortedContents.count]
        
        let sortedDirContents = sorted(dirContents) { a, b in return a.0 < b.0 }
        let sortedFileContents = sorted(fileContents) { a, b in return a.0 < b.0 }
        
        for content in sortedDirContents {
            self.contentsOfPath.append(content)
        }
        
        for content in sortedFileContents {
            self.contentsOfPath.append(content)
        }
        
        return self.contentsOfPath
    }
}
