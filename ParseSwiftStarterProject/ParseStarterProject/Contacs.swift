//
//  Contacs.swift
//  place
//
//  Created by david on 13/08/15.
//  Copyright (c) 2015 placeap. All rights reserved.
//

import UIKit

class Contact: NSObject {
    var firstName : String
    var lastName : String
    //var birthday: NSDate?
    var thumbnailImage: NSData?
    var originalImage: NSData?
    
    // these two contain emails and phones in <label> = <value> format
    var emailsArray: Array<Dictionary<String, String>>?
    var phonesArray: Array<Dictionary<String, String>>?
    
    override var description: String { get {
        return "\(firstName) \(lastName)  \nPhones: \(phonesArray) \nEmails: \(emailsArray)\n\n"}
        //   return "\(firstName) \(lastName) \nBirthday: \(birthday) \nPhones: \(phonesArray) \nEmails: \(emailsArray)\n\n"}
    }
    
    //init(firstName: String, lastName: String, birthday: NSDate?)
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        //self.birthday = birthday
    }
}