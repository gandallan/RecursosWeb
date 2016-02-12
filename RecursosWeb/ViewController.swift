//
//  ViewController.swift
//  RecursosWeb
//
//  Created by Gandhi Mena Salas on 12/02/16.
//  Copyright © 2016 Trenx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ISBNField: UITextField!
    @IBOutlet weak var resultadoDatos: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ISBNField.clearButtonMode = .WhileEditing
        
        
    }
    
//************ Funcion de Búsqueda del libro
    @IBAction func BusquedaISBN(sender: UITextField) {
        
        verLibro()
        
    }
    
//************ Funcion Ver Libro
    func verLibro(){
        if Reachability.isConnectedToNetwork() == true {
            self.activityIndicator.startAnimating()
            
            let ISBN:String! = ISBNField.text
            print(ISBN)
            
            let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
            let url = NSURL(string: urls + ISBN)
            let session = NSURLSession.sharedSession()
            let bloque = {(datos: NSData?, resp: NSURLResponse?, error: NSError?) -> Void in
                dispatch_async(dispatch_get_main_queue()){
                    
                    self.activityIndicator.stopAnimating()
                }
                if (error == nil){
                    
                    let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
                    dispatch_async(dispatch_get_main_queue()){
                        
                        self.resultadoDatos.text = texto! as String
                    }
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(),{
                        
                        self.alert(title: "Error de conexión", message: "revisa tu conexión a internet")
                    })
                    
                }
                
            }
            
            let datos = session.dataTaskWithURL(url!, completionHandler: bloque)
            datos.resume()
            
        }
    }
    
    
//********************* Alert
    func alert(title title:String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
//*********************Toggle Keboard
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField!)-> Bool{
        textField.resignFirstResponder()
        
        return true
        
    }
    



}

