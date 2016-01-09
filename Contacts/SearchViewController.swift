//
//  SearchViewController.swift
//  Contacts
//
//  Created by Chris Archibald on 1/9/16.
//  Copyright © 2016 Chris Archibald. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {
    
    var appDel: AppDelegate = AppDelegate()
    var context: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)

    override func viewDidLoad() {
        super.viewDidLoad()

        appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        context = appDel.managedObjectContext
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
