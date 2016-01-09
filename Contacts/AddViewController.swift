//
//  AddViewController.swift
//  Contacts
//
//  Created by Chris Archibald on 1/9/16.
//  Copyright © 2016 Chris Archibald. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    @IBAction func save(sender: AnyObject) {
        if firstName.text == "" || lastName.text == "" || phone.text == "" || email.text == ""  {
            let alertController = UIAlertController(title: "Error", message: "All Text Fields Are Required", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            self.view.endEditing(true)
            let newContract = NSEntityDescription.insertNewObjectForEntityForName("Contacts", inManagedObjectContext: context) as NSManagedObject
            
            newContract.setValue(firstName.text, forKey: "firstName")
            newContract.setValue(lastName.text, forKey: "lastName")
            newContract.setValue(email.text, forKey: "email")
            newContract.setValue(phone.text, forKey: "phone")
            
            do {
                try context.save()
                let alertController = UIAlertController(title: "Success", message: "Record Saved Successfully", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                
                firstName.text = ""
                lastName.text = ""
                email.text = ""
                phone.text = ""
                
            } catch _ {
                let alertController = UIAlertController(title: "Error", message: "Something went wrong while saving record", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
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
