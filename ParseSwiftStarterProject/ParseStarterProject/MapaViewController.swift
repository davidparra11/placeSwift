//
//  MapaViewController.swift
//  PlaceAp
//
//  Created by david on 30/07/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

@available(iOS 8.0, *)
class MapaViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapa: MKMapView!  //mk es mapkit
    var localicionusuario = CLLocationManager()
    
    // var manager = clllocation!; manager.delegate = self
    
    
    
    
    func accion(gestureRecognizer: UIGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
        
        let puntoDeToque = gestureRecognizer.locationInView(self.mapa)
        
        let nuevaCoordenada:CLLocationCoordinate2D = self.mapa.convertPoint(puntoDeToque, toCoordinateFromView: self.mapa)
        
        let anotacion = MKPointAnnotation()
        anotacion.coordinate = nuevaCoordenada
        anotacion.title = "una nueva cordenada"
        anotacion.subtitle = "la ha creado el usuario"
        
        self.mapa.addAnnotation(anotacion)

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        localicionusuario.delegate = self //vamos a decirle quien es el delegado es decit quien se va a enterar de actualizar segun cambie posciones del user
        localicionusuario.desiredAccuracy = kCLLocationAccuracyBest
        localicionusuario.requestWhenInUseAuthorization() //solo cuando la app esta en uso (aqui damos por echo de que el usario nos permitio susar el gps
        localicionusuario.startUpdatingLocation() //llama a la funicion didupdatelocations
        
        
        
        
        let latitude: CLLocationDegrees = 40.4
        let longitude: CLLocationDegrees = -3.7
        
        let latDelta: CLLocationDegrees = 0.1
        let lonDelta: CLLocationDegrees = 0.1
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta) //es un tipo de¡iferente y para utilizarlo voy a usar una funcion con esos valores
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude,
            longitude)//es como definir  un punto en un mapa
        let region:MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        //ya crado todo esto le puedo decir al mapa
        mapa.setRegion(region, animated: true) //el animated es para una ransicion leve
        
        
        let anotacion = MKPointAnnotation()
        anotacion.coordinate = location
        anotacion.title = "cualquier point"
        anotacion.subtitle = "take care con l,os fantasmas"
        
        mapa.addAnnotation(anotacion)
        
        
        
        //vamos a utilizar un gestor de reconociminto hay uno en especifico para dejaar pulsado el dedo
        let lpgr = UILongPressGestureRecognizer(target: self, action: "accion:") //el motivo por los 2 puntps es que el gestur recognation manda un parametro; si le quito los 2 puntos llama a una funcion que no recibe ningun argumento, por eso con esto llama a una func que recibe argumenots
        lpgr.minimumPressDuration = 2
        mapa.addGestureRecognizer(lpgr)
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { //es el que se entera realmente de que huo un cambio de posicion
        //println(locations)
        var locacionUsuario:CLLocation = locations[0] //[0]por si se han acumulado en la cola del gps
       // println("latitude \(locacionUsuario.coordinate.latitude) rumbo \(locacionUsuario.course) velocidad \(locacionUsuario.speed) y la altitud ")
        
       /* CLGeocoder().reverseGeocodeLocation(locacionUsuario, completionHandler: { (lugares, error) -> Void in
            if error != nil {
                print(error)
            }else
            {
                if let p = CLPlacemark(placemark: lugares?[0] as! CLPlacemark){  //cogo el primero y puede que este vacion por eso el ? y si no hay ninguno no se va a ejecutar eñ codigo del if let
                // println("pais \(p.country) postal code \(p.postalCode) etc ")
                    var k = 1
                    
                
                }
            }
        })
        
        
        
        if let validPlacemark = placemarks?[0]{
            let placemark = validPlacemark as? CLPlacemark;
        }*/
            
        
        var lati = locacionUsuario.coordinate.latitude
        var long = locacionUsuario.coordinate.longitude
        //ahora vamos a centrar el mapa
        
        
        var latDelta: CLLocationDegrees = 0.01
        var lonDelta: CLLocationDegrees = 0.01
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta) //es un tipo de¡iferente y para utilizarlo voy a usar una funcion con esos valores
        
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lati,
            long)//es como definir  un punto en un mapa
        var region:MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        //ya crado todo esto le puedo decir al mapa
        mapa.setRegion(region, animated: true) //el animated es para una ransicion leve
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
