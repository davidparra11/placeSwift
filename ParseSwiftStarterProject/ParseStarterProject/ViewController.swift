//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBAction func didLogout(segue: UIStoryboardSegue) {
        print("logout")
    }
    
    
    @IBAction func iniciartodo(sender: AnyObject) {
        if PFUser.currentUser() != nil {
            performSegueWithIdentifier("jumpfrominicotomap", sender: self)
        }

    }


    override func viewDidLoad() {
        super.viewDidLoad()
        //inicialiazar parse
       Parse.setApplicationId("rBMIBPCMX0D93ggVw8cLff1jEyydUnPQIM2djZjF",
            clientKey: "RuxNpiBRUKYN9ZISrIGTBBiINHoO1TzGKywAfKrx")
        /*
        //crear un objeto en parse y recibe un nombre de clase
         var usuarios = PFObject(className: "users")
        //vamos a darles unos valores
        usuarios.setObject("email", forKey: "david@hotmail.com")
        usuarios.setObject("password", forKey: "pass")
        usuarios.saveInBackgroundWithBlock(nil)
        
        */
       
        
        if PFUser.currentUser() != nil {
            performSegueWithIdentifier("jumpfrominicotomap", sender: self)
        }

        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        if PFUser.currentUser() != nil {
            performSegueWithIdentifier("jumpfrominicotomap", sender: self)
        }
        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("jumpfrominicotomap", sender: self)
        }

    }
    
    
    override func viewWillAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            performSegueWithIdentifier("jumpfrominicotomap", sender: self)
            //self.view.hidden = true
        }

    }
}

