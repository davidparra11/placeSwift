//
//  ViewControllerStarSession.swift
//  PlaceAp
//
//  Created by david on 28/07/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit

var user = PFUser()

@available(iOS 8.0, *)
class ViewControllerStarSession: UIViewController {

    
    var cargando = UIActivityIndicatorView()
    
    
    @IBAction func loginWithFB(sender: AnyObject) {
        print("boton de logueo con face1")
        
        
      //  self.loginCancelledLabel.hidden = true
        
        let permissions = ["public_profile"] //variable de permisos; un array de pernmisos
        // el user lo recibe como opcional y si nos damos cuenta para conectarnnos con FB nos pide permisos
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions, block: {
            (user: PFUser?, error: NSError?) -> Void in
            print("boton de logueo con face2")
            if let user = user {
                if user.isNew {
                    print("User signed up and logged in through Facebook!")
                    
                   // self.performSegueWithIdentifier("signUp", sender: self)
                    
                } else {
                    print("User logged in through Facebook!")
                    //self.performSegueWithIdentifier("showTinder", sender: self)
                }
            } else {
                print("Uh oh. The user cancelled the Facebook login.")
               // self.loginCancelledLabel.hidden = false;
            }
        })
        
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions)
        
        
        
    }
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var infoLabel: UILabel!
    //funion para dispara cuando ocurre el error (para poderlo mostrar cuando la necesite mostrar el error, desde aqui o descde cualquier parte de la app
    func displayAlerta(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .Default, handler:
            { (action) -> Void in
                //self.dismissViewControllerAnimated(true, completion: nil)  //para quitar el actual view controller
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func signUpButton(sender: AnyObject) {
            var error = ""
        
        if self.username.text == "" || self.email.text == "" {
            error = "la contraseña o el email no ha sido ingresado"
            self.infoLabel.hidden = false
            
        }else{
            //println("usuario registrado")
            //self.infoLabel.hidden = true
            
            cargando.center = self.view.center
            cargando.hidesWhenStopped = true
            cargando.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            cargando.startAnimating()
            self.view.addSubview(cargando)
            UIApplication.sharedApplication().beginIgnoringInteractionEvents() //acrodarme de quitar el cargando pra que mi app pueda de nuevo recibir eventos
            
            
          //  var user = PFUser() //objeto de parse
            
            user.username = self.username.text
            user.password = self.password.text
            user.email = email.text
            // other fields can be set just like with PFObject
            user["phone"] = "415-392-0202"
            
            user.signUpInBackgroundWithBlock { //otra linea de ejecucion
                (succeeded: Bool, singUperror: NSError?) -> Void in
                
                self.cargando.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()//finalizar la ignoracion de eventos
            
                
                if let singUperror = singUperror {
                        if let errorString = singUperror.userInfo["error"] as? NSString {
                    self.displayAlerta("error al registrar", message: String(errorString))
                        }
                        else {
                            error = "reintitentar"
                            self.displayAlerta("error al registrar", message: "por avor reintentar")
                        }
                    // Show the errorString somewhere and let the user try again.
                } else {
                    // Hooray! Let them use the app now.
                    print("usussrio regustrado")
                }
            }
            
            
        }
        
        if error != "" {
            
            self.displayAlerta("Error de formualiro", message: error)
       
            
        }
    
        
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(PFUser.currentUser()) //ultimo  usaurio logueado
        
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
