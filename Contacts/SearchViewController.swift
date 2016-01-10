//
//  SearchViewController.swift
//  Contacts
//
//  Created by Chris Archibald on 1/9/16.
//  Copyright © 2016 Chris Archibald. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var results: [AnyObject]?
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var appDel: AppDelegate = AppDelegate()
    var context: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)

    override func viewDidLoad() {
        super.viewDidLoad()

        appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        context = appDel.managedObjectContext
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchText.text = ""
        searchLabel.text = "0 Reconds Found"
        loadData(searchText.text!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        loadData(searchText.text!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func search(sender: AnyObject) {
        self.view.endEditing(true)
        loadData(searchText.text!)
    }
    
    func loadData(search: String) {
        results = [AnyObject]()
        let request = NSFetchRequest(entityName: "Contacts")
        request.resultType = NSFetchRequestResultType.DictionaryResultType
        
        if search != "" {
            request.predicate = NSPredicate(format: "firstName = %@", search)
        }
        
        let sort1 = NSSortDescriptor(key: "firstName", ascending: true)
        let sort2 = NSSortDescriptor(key: "lastName", ascending: true)
        
        request.sortDescriptors = [sort1, sort2]
        
        do {
            results = try context.executeFetchRequest(request)
        } catch _ {
            let alertController = UIAlertController(title: "Error", message: "Error Ferching Records from CoreData", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        tableView.reloadData()
        searchLabel.text = (results?.count)! > 1 ? "\((results?.count)!) reconds found" : "\((results?.count)!) recond found"
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ContactTableViewCell
        
        let firstName: String = results![indexPath.row].valueForKey("firstName")! as! String
        let lastName: String = results![indexPath.row].valueForKey("lastName")! as! String
        let email: String = results![indexPath.row].valueForKey("email")! as! String
        let phone: String = results![indexPath.row].valueForKey("phone")! as! String
        
        cell.nameLabel.text = firstName + " " + lastName
        cell.emailLabel.text = email
        cell.phoneLabel.text = phone
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (results?.count)!
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
