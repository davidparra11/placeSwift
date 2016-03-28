//
//  UsersTableViewController.swift
//  PlaceAp
//
//  Created by david on 30/07/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

var contadorFila:Int = 0  //var global


class UsersTableViewController: UITableViewController {
    
    var usuarios = [String]()
    var following = [Bool]() //array para saber quienes estamos siguiendo
    
    
    var refrescador:UIRefreshControl!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refrescador = UIRefreshControl()
        self.refrescador.attributedTitle = NSAttributedString(string: "arrastra para recargar")
        self.refrescador.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged) // targes es que llame un metodo que va a llamarrlo a mi view controler o que esta dentro de mi viewcontroler   dentro del ation no recibe ningun arumenot solo es el "refresh"
        self.tableView.addSubview(self.refrescador) //vamos a decirle a latabla que tiene un refresher
        
        
     /*   var query = PFUser.query()
        query?.findObjectsInBackgroundWithBlock({ (objetos:[AnyObject]?, error:NSError?) -> Void in
            self.usuarios.removeAll(keepCapacity: true) //vaciar el array de usuarios luego los vcamos a ir ñadiendo
            for objeto in objetos!{
                var usuario:PFUser = objeto as! PFUser //el ! es por que es un anyobject y despues no sabremos si es pfuser
                
                if usuario.username != PFUser.currentUser()?.username {
                    self.usuarios.append(usuario.username!)
                }
                
            }
            
           self.tableView.reloadData() //una vez que ya alla savcado todos los usuarios, que la tabla actualize paa que cargeue los datso
            
        })*/
        
        self.actualizarUsuarios()
        
        
       /* var followingQuery = PFQuery(className:"followers")
        followingQuery.whereKey("follower", equalTo:(PFUser.currentUser()?.username)!)
        followingQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            println("usuario actual \(PFUser.currentUser())  y mirando elarraay objetos \(objects!) ")
            
            if error == nil {
                if let followingPeople = objects as? [PFObject] {
                    
                    var query = PFUser.query()
                    query?.findObjectsInBackgroundWithBlock({ (objetos:[AnyObject]?, error:NSError?) -> Void in
                        self.usuarios.removeAll(keepCapacity: true) //vaciar el array de usuarios luego los vcamos a ir ñadiendo
                        for objeto in objetos!{
                            var usuario:PFUser = objeto as! PFUser //el ! es por que es un anyobject y despues no sabremos si es pfuser
                            
                            if usuario.username != PFUser.currentUser()?.username {
                                self.usuarios.append(usuario.username!)
                                println("obser el objeto \(self.usuarios)")
                                var isFollowing:Bool = false
                                for followingPerson in followingPeople {
                                    if followingPerson["following"] as? String == usuario.username {
                                        isFollowing = true
                                    }
                                }
                                
                                self.following.append(isFollowing)
                            }
                        }
                        
                        self.tableView.reloadData()
                    })
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error!.userInfo!)")
            }
        }*/

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
    
    func actualizarUsuarios() {
        var followingQuery = PFQuery(className:"followers")
        followingQuery.whereKey("follower", equalTo:(PFUser.currentUser()?.username)!)
        followingQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            print("usuario actual \(PFUser.currentUser())  y mirando elarraay objetos \(objects!) ")
            
            if error == nil {
                if let followingPeople = objects as? [PFObject] {
                    
                    var query = PFUser.query()
                    
                    query?.findObjectsInBackgroundWithBlock({ (objetos:[AnyObject]?, error:NSError?) -> Void in
                        self.usuarios.removeAll(keepCapacity: true) //vaciar el array de usuarios luego los vcamos a ir ñadiendo
                        self.following.removeAll(keepCapacity: true)
                        for objeto in objetos!{
                            var usuario:PFUser = objeto as! PFUser //el ! es por que es un anyobject y despues no sabremos si es pfuser
                            
                            if usuario.username != PFUser.currentUser()?.username {
                                self.usuarios.append(usuario.username!)
                                print("obser el objeto \(self.usuarios)")
                                var isFollowing:Bool = false
                                for followingPerson in followingPeople {
                                    if followingPerson["following"] as? String == usuario.username {
                                        isFollowing = true
                                    }
                                }
                                
                                self.following.append(isFollowing)
                            }
                        }
                        
                        self.tableView.reloadData()
                        self.refrescador.endRefreshing()
                    })
                }
            } else {
                // Log details of the failure
                print("Error: \(error) \(error!.userInfo)")
                self.refrescador.endRefreshing()
            }
        }
        
    }
    
    //voy a crear el metodo de refresh
    func refresh(){
        //println("refrescando")
        self.actualizarUsuarios()
    }
    
    
    

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
        return self.usuarios.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 

        // Configure the cell...
        cell.textLabel?.text = self.usuarios[indexPath.row]
        
        print("observando el objoto following \(following)")
        
        if following[indexPath.row] {     //si esto es cierto deberia de tener marca
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }else
        {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        

        return cell
    }
    
   // tableview
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if cell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            var query = PFQuery(className:"followers")
            query.whereKey("follower", equalTo:(PFUser.currentUser()?.username)!)
            query.whereKey("following", equalTo:(cell.textLabel?.text)!)
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    // The find succeeded.
                    print("Successfully retrieved \(objects!.count) scores.")
                    // Do something with the found objects
                    if let objects = objects as? [PFObject] {
                        for object in objects {
                            print(object.objectId) //comnetar
                            object.deleteInBackgroundWithBlock(nil)
                        }
                    }
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }

            
        
        }
            else {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            
            var following = PFObject(className: "followers") //nos creamos un objeto de clase folowers
            following["following"] = cell.textLabel?.text //following de following de la clase en parse
            following["follower"] = PFUser.currentUser()?.username //el followr simepre voy a ser yo
            following.saveInBackgroundWithBlock(nil)  //este objeos me lo guardas en segundo plano y le ponemos nil por rapides no necsitamos saber si todo fue correcot
            
        }
    }
    
   @IBAction func timeLien(sender: AnyObject) {
       
    }

   
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        //normalmente usamos el didselect pero vamos a usar el el will por que cunando en mi fila pulse sobre ella ire a otra pantalla si uso did sera demasiado tarde porq ya se habra producido la transicion con wil el cod que se va a ejecutar va ser justo antes de que se produsca la transision . indexpath es el argumento es el que me dice que fila es el quese a pulsado
        contadorFila = indexPath.row
        return indexPath 
        
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

}
