//
//  UsuarioViewController.swift
//  PlaceAp
//
//  Created by david on 31/07/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse


@available(iOS 8.0, *)
class UsuarioViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    @IBOutlet weak var activitIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var imageParaPostear: UIImageView!
    
    @IBOutlet weak var compartirText: UITextField!
    
    var photoselected:Bool = false
    
    func mostrarAlerta(titulo:String, subtitulo:String){
        let alerta = UIAlertController(title: titulo, message: subtitulo, preferredStyle: UIAlertControllerStyle.Alert)
        alerta.addAction(UIAlertAction(title: "Acepata", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alerta, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func elegirImagen(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.allowsEditing = false
        picker.delegate = self  //su delegado el que se va a enterar cuando quiero una foto, soy yo mismo
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.imageParaPostear.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        photoselected = true
        
        
        
    }

    @IBAction func publicar(sender: AnyObject) {
        var error=""
        if !photoselected {
            error = "por favor deje una imagen"
        }else if compartirText.text == "" {
            error = "por favor escribe un texto"
        }
        if error != "" {
            self.mostrarAlerta("error en los datos", subtitulo: error)
        }
        else{
            //ya esta listo para publicar
            var postear = PFObject(className: "Posteos")
            postear["title"] = compartirText.text
            let imagenData = UIImagePNGRepresentation(self.imageParaPostear.image!)
            let imagenFile = PFFile(name: "imagenusuario.png", data: imagenData!)
            postear["imageFile"] = imagenFile
            postear["username"] = PFUser.currentUser()?.username
            
            self.activitIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            postear.saveInBackgroundWithBlock({ (succees, error) -> Void in
                if succees {
                   // println("publicacion realixafa")
                    var alerta = UIAlertController(title: "publicacion completada", message: "publicacion exitosa", preferredStyle: UIAlertControllerStyle.Alert)
                    alerta.addAction(UIAlertAction(title: "Acepata", style: .Default, handler: { (action) -> Void in
                       // self.dismissViewControllerAnimated(true, completion: nil)
                    }))
                    
                    self.presentViewController(alerta, animated: true, completion: nil)
                    
                }else
                {
                       self.mostrarAlerta("no se pudo publicar", subtitulo: "no se pudieron subir los datos")
                    
                }
                self.photoselected = false
                self.compartirText.text = ""
                self.imageParaPostear.image = UIImage(named: "placeholder.png")
                self.activitIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
            })
            
        
        
        
        }
    }

    
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("logOut", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activitIndicator.stopAnimating()//esta parado desde el principio

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {//es el metodo que se va a ejecutar cuando se toque alfuna parte de la pantalla que no respontde a pulsaciones
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        print("proabdo el teckado")
        return true
        
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
