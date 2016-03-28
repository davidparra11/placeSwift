//
//  ContactosTableViewController.swift
//  PlaceAp
//
//  Created by david on 10/08/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import AddressBook
var namesFriends = Array<Contact>()


class ContactosTableViewController: UITableViewController {
    
   

    //    var Contact = StringstringInterpolationSegment: (String)
    
    
    
    
    
    
    
    var nombresAmigos = [NSArray]()
    //var imagenesAmigos = [PFFile]()
    
    
    
    
    
    
    
    func showContacts(contacts: Array<Contact>) {
        let alertView = UIAlertView(title: "Success!", message: "\(contacts.count) contacts imported successfully", delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
    }
    
    
    
    
    
        
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            print("amigos")
            ContactsImporter.importContacts(showContacts)
            
            
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false
            
            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    
            
            
        }
    
   /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
   
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return usernames.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath) as! TLineTableViewCell
        
        // Configure the cell...
        cell.nombre.text = self.usernames[indexPath.row]
        
        cell.descripcion.text = self.descripciones[indexPath.row]
        self.images[indexPath.row].getDataInBackgroundWithBlock { (imagenData:NSData?, error:NSError?) -> Void in
            if error == nil {
                let imagen = UIImage(data: imagenData!)
                cell.postImage.image = imagen
                //todo esto lo va recuperndao paulatinamente por el metodo
            }
        }
        
        return cell
    }*/

    
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
            return namesFriends.count
        }

    
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("amigoCell", forIndexPath: indexPath) as! ContactosTableViewCell
            
            // Configure the cell...
            cell.nombreAmigo.text = "\(namesFriends[indexPath.row].firstName) \(namesFriends[indexPath.row].lastName)"
            
            //cell.descripcion.text = self.descripciones[indexPath.row]
            /*self.images[indexPath.row].getDataInBackgroundWithBlock { (imagenData:NSData?, error:NSError?) -> Void in
                if error == nil {
                    let imagen = UIImage(data: imagenData!)
                    cell.postImage.image = imagen
                    //todo esto lo va recuperndao paulatinamente por el metodo
                }
            }*/
            
            return cell
        }
        /*
        override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 300
            
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
        
        /*
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        }
        */
        */
    


}


class ContactsImporter {


    
    private class func extractABAddressBookRef(abRef: Unmanaged<ABAddressBookRef>!) -> ABAddressBookRef? {
        if let ab = abRef {
            return Unmanaged<NSObject>.fromOpaque(ab.toOpaque()).takeUnretainedValue()
        }
        return nil
    }
    
    class func importContacts(callback: (Array<Contact>) -> Void) {
        if(ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Denied || ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Restricted) {
            let alert = UIAlertView(title: "Acceso a los contactos del telefono denegado", message: "Ppor favor periminaton el acceso por Settings -> Privacy -> Contacts", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return
        }
        else if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.NotDetermined) {
            var errorRef: Unmanaged<CFError>? = nil
            let addressBook: ABAddressBookRef? = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, &errorRef))
            ABAddressBookRequestAccessWithCompletion(addressBook, { (accessGranted: Bool, error: CFError!) -> Void in
                if(accessGranted) {
                    let contacts = self.copyContacts()
                    callback(contacts)
                }
            })
        }
        else if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Authorized) {
            let contacts = self.copyContacts()
            callback(contacts)
        }
    }
    
    class func copyContacts() -> Array<Contact> {
        var errorRef: Unmanaged<CFError>? = nil
        let addressBook: ABAddressBookRef? = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, &errorRef))//retorn un objeto address book
        let contactsList: NSArray = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as NSArray
        print("\(contactsList.count) records in the array o registro en la variable de conatacs List")
        
        var importedContacts = Array<Contact>()
        
        
        
        
        for record:ABRecordRef in contactsList {
            let contactPerson: ABRecordRef = record
            let firstName: String = ABRecordCopyValue(contactPerson, kABPersonFirstNameProperty).takeRetainedValue() as! NSString as String
            let lastName: String = ABRecordCopyValue(contactPerson, kABPersonLastNameProperty).takeRetainedValue() as! NSString as String
            
            print("-------------------------------")
            print("\(firstName) \(lastName) \(contactPerson)")
            
            let phonesRef: ABMultiValueRef = ABRecordCopyValue(contactPerson, kABPersonPhoneProperty).takeRetainedValue() as ABMultiValueRef
            var phonesArray  = Array<Dictionary<String,String>>()
            for var i:Int = 0; i < ABMultiValueGetCount(phonesRef); i++ {
                let label: String = ABMultiValueCopyLabelAtIndex(phonesRef, i).takeRetainedValue() as NSString as String
                let value: String = ABMultiValueCopyValueAtIndex(phonesRef, i).takeRetainedValue() as! NSString as String
                
                print("Phone: \(label) = \(value)")
                
                let phone = [label: value]
                phonesArray.append(phone)
            }
            
            print("All Phones: \(phonesArray)")
            
            /*var emailsRef: ABMultiValueRef = ABRecordCopyValue(contactPerson, kABPersonEmailProperty).takeRetainedValue() as ABMultiValueRef
            var emailsArray = Array<Dictionary<String, String>>()
            for var i:Int = 0; i < ABMultiValueGetCount(emailsRef); i++ {
            var label: String = ABMultiValueCopyLabelAtIndex(emailsRef, i).takeRetainedValue() as NSString as String
            var value: String = ABMultiValueCopyValueAtIndex(emailsRef, i).takeRetainedValue() as! NSString as String
            
            println("Email: \(label) = \(value)")
            
            var email = [label: value]
            emailsArray.append(email)
            }
            
            println("All Emails: \(emailsArray)")
            
            var birthday: NSDate? = ABRecordCopyValue(contactPerson, kABPersonBirthdayProperty).takeRetainedValue() as? NSDate
            
            println ("Birthday: \(birthday)")
            
            var thumbnail: NSData? = nil
            var original: NSData? = nil
            if ABPersonHasImageData(contactPerson) {
            thumbnail = ABPersonCopyImageDataWithFormat(contactPerson, kABPersonImageFormatThumbnail).takeRetainedValue() as NSData
            original = ABPersonCopyImageDataWithFormat(contactPerson, kABPersonImageFormatOriginalSize).takeRetainedValue() as NSData
            }*/
            
            let currentContact = Contact(firstName: firstName, lastName: lastName) //birthday: birthday)
            currentContact.phonesArray = phonesArray
            // currentContact.emailsArray = emailsArray
            //currentContact.thumbnailImage = thumbnail
            //currentContact.originalImage = original
            
            importedContacts.append(currentContact)
            namesFriends.append(currentContact)
            
            
            
        }
        print("importedContacs \(importedContacts)")
        //  ContactosTableViewController.copyContacts().
        print("importedContacs solo nomreb \(importedContacts[0].firstName)")
        //namesFriends.append(importedContacts)
        namesFriends = importedContacts
        return importedContacts
    }



}
