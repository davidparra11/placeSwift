//
//  ViewControllerIniSesion.swift
//  PlaceAp
//
//  Created by david on 29/07/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

@available(iOS 8.0, *)
class ViewControllerIniSesion: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var cargando = UIActivityIndicatorView()
    
    
    
    func displayAlerta(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .Default, handler:
            { (action) -> Void in
                //self.dismissViewControllerAnimated(true, completion: nil)  //para quitar el actual view controller
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func singInButton(sender: AnyObject) {
        
        
        
        var error = ""
        
        if self.email.text == "" || self.password.text == "" {
            error = "la contraseña o el email no ha sido ingresado"
            //self.infoLabel.hidden = false
            
        }else{
            //println("usuario registrado")
            //self.infoLabel.hidden = true
            
            cargando.center = self.view.center
            cargando.hidesWhenStopped = true
            cargando.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            cargando.startAnimating()
            self.view.addSubview(cargando)
            UIApplication.sharedApplication().beginIgnoringInteractionEvents() //acrodarme de quitar el cargando pra que mi app pueda de nuevo recibir eventos
        
        
        //PFUser is a class con un metodo login with...
        
            PFUser.logInWithUsernameInBackground(self.email.text!, password:self.password.text!) {
            (user: PFUser?, loginerror: NSError?) -> Void in
            
            self.cargando.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()//finalizar la ignoracion de eventos
            
            
            if user != nil {
                // Do stuff after successful login.
                print("el usuario a  podido acceder")
                
            } else {
                // The login failed. Check error to see why.
                if let errorString = loginerror!.userInfo["error"] as? NSString {
                    self.displayAlerta("error al acceder", message: String(errorString))
                }
                else {
                    error = "reintitentar"
                    self.displayAlerta("error al acceder", message: "por avor reintentar")
                }

                
            }
            }
        }
        
        

        
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       // println(PFUser.currentUser()!)

        // no deberia lanzar trnasicion hasta que la pantalla no halla aparecido por eso el willAPear (justo cuando va a aparecer pero todavia no ha aparecido por eso vamos a utilizar el did
    }
    
    override func viewDidAppear(animated: Bool) {
        //si alguno ha hecho login (pfuser current lanzamos la aplicacion con el lansar)
        if PFUser.currentUser() != nil {
            performSegueWithIdentifier("saltaralatablausuarios", sender: self)
        }
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

/*

PFUser.logInWithUsernameInBackground("myname", password:"mypass") {
    (user: PFUser?, error: NSError?) -> Void in
    if user != nil {
        // Do stuff after successful login.
    } else {
        // The login failed. Check error to see why.
    }
}











func displayAlerta(title:String, message:String){
    var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
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
        
        
        var user = PFUser()
        
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
                if let errorString = singUperror.userInfo?["error"] as? NSString {
                    self.displayAlerta("error al registrar", message: String(errorString))
                }
                else {
                    error = "reintitentar"
                    self.displayAlerta("error al registrar", message: "por avor reintentar")
                }
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
                println("usussrio regustrado")
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


}*/*/
