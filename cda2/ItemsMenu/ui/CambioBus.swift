//
//  CambioBus.swift
//  cda2
//
//  Created by Emilio Castro on 1/23/20.
//  Copyright © 2020 Emilio Castro. All rights reserved.
//

import UIKit

class CambioBus: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource    {
    
   
  
    

    struct alumno: Decodable {
        var codigo: String!
        var nombre: String!
        var grado: String!
        var carrera: String!
        var seccion: String!
        var ruta1: String!
        var direccion1: String!
        var ruta2: String!
        var direccion2: String!
        var bajaSolo: String!
    }
    struct rutas: Decodable {
        var codRuta: String!
        var Ruta: String!
        var direcciones: [direcciones]!
    }
    struct direcciones: Decodable {
        var codDireccion: String!
        var Direccion: String!
    }
    
    struct Decodificador: Decodable {
        var cod_familia: String!
        var apellidos_familia: String!
        var rol: String!
        var alumno: [alumno]!
        var rutas: [rutas]!
        
    }
    
    @IBOutlet weak var fechaPV: UIDatePicker!
    @IBOutlet weak var datosAlumno: UILabel!
    @IBOutlet weak var datosRutaAlumno: UILabel!
    @IBOutlet weak var pickerAlumno: UIPickerView!
    var filaSeleccionada  = 1
      var totalElementos = 1
    var arrayElementos: [String] = ["Seleccione un Alumno"]
    var arrayIndice: [Int] = [-1]
    var Arralumno = alumno()
    var Arrrutas = rutas()
    var product = Decodificador()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerAlumno.dataSource = self
        pickerAlumno.delegate = self
              
        // Do any additional setup after loading the view.
        loadProfile()
        fechaPV.isEnabled = false
        self.fechaPV.minimumDate = Date()
    }
   
    func loadProfile(){
      
        let accessToken: String? = "UnidSIFPuUuBgByUGTub4b3A2DuHvb60rkAn4GK2pKFw8qsbHcE11a75w-lib296zkXAcgjUfgg0MGxapaSs6OcDalc1qnGo87GSRX7ww5otspdgzqOE0WxWnTYtCMcFiQscpSwpmGgcWSO3ip8SD9iTg8OysyTMirMEwg-hfeqUE5p5Mz0ih_xQxvoTXJ4obPRDoaVzmslMZZzfMprDS-PJWME83KVwCplJXe90qD92J8iKqKpxB5Dtu3SoizeOpCZAEdGeD0oQUh1lHGUadw"
       // let accessToken: String? = KeychainWrapper.standard.string(forKey: "accessToken")
       // let userId: String? = KeychainWrapper.standard.string(forKey: "userId")
        let myUrl = URL(string: "http://ecastro-001-site1.atempurl.com/api/cda/getCambioBus")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken!)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request){ (data: Data?, response: URLResponse?, error: Error?) in
        //    print(request)
            //print(response)
            
            print(data!)
            if error != nil {
              // self.displayMessage(userMessage: "Error request")
                print("errorEC= \(String(describing: error))")
                return
            }
            
            do{
                let decoder = JSONDecoder()
                self.product = try decoder.decode(Decodificador.self, from: data!)

              //  print(product.cod_familia)
              //  print(product.apellidos_familia)
                print(self.product.alumno!.count)
                print(self.product.rutas!.count)
                self.totalElementos = self.product.alumno!.count+1
          
                for i in 0...self.product.alumno!.count-1 {
              
                    self.arrayElementos.append(self.product.alumno![i].nombre!)
                self.arrayIndice.append(i)
                }
                
            }catch {
                //self.displayMessage(userMessage: "Error perform the request")
                print(error)
            }
           
        /*   do {
            //let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
             // print("json --> \(json)")
            
            if let parseJSON2 = try? JSONDecoder().decode(User.self, from: unwrappedData){
                                       
                if let parseJSON = json {
                    DispatchQueue.main.async {
                        let codfam: String? = parseJSON["alumno"] as? String
                        let rolfam: String? = parseJSON["grado"] as? String
                        
                        print("codfam -->\(codfam)")
                        print("rolfam-->\(rolfam)")
                    }
                }else {
                  //  self.displayMessage(userMessage: "Error de json")
                    print("Error de json")
                }
            }catch {
                //self.displayMessage(userMessage: "Error perform the request")
                print(error)
            }*/
            DispatchQueue.main.async { // Correct
            self.pickerAlumno.reloadAllComponents()
            }
        }
        task.resume()
    
    
       
        
    }

  /*  func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default){ (action:UIAlertAction!) in print("OK button tapped")}
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return totalElementos
       }
       
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          return arrayElementos[row]
       }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Elemento seleccionado -> \(arrayElementos[row].description)")
        print("Elemento con Indice -> \(arrayIndice[row].description)")
        filaSeleccionada = row
          datosRutaAlumno.text =  ""
        if (arrayIndice[row].description == "-1") {
            print("No debe buscar nada")
             fechaPV.isEnabled = false
            datosAlumno.text = ""
          
        }else {
            fechaPV.isEnabled = true
            datosAlumno.text = "Codigo Alumno: \(self.product.alumno![arrayIndice[row]].codigo ?? "0") Carrera: \( self.product.alumno![arrayIndice[row]].carrera ?? "") Grado: \(self.product.alumno![arrayIndice[row]].grado ?? "") Seccion:  \(self.product.alumno![arrayIndice[row]].seccion ?? "")"
          //  codigo carrera grado seccion
       
          
        }
    }
    
    @IBAction func cambioFecha(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
        
        print(dateFormatter.string(from: sender.date))
        dateFormatter.dateFormat = "EEEE"
        
        print(dateFormatter.string(from: sender.date))
        
        let bs = self.product.alumno![arrayIndice[filaSeleccionada]].bajaSolo ?? "No" == "S" ? "Si" :  "No"
        
        if (dateFormatter.string(from: sender.date) != "Friday" ){
            datosRutaAlumno.text = "La Ruta actual del alumno es: \(self.product.alumno![arrayIndice[filaSeleccionada]].ruta1 ?? ""). En la direccion: \(self.product.alumno![arrayIndice[filaSeleccionada]].direccion1 ?? "") el alumno \(bs) baja solo. "
        }else {
              datosRutaAlumno.text = "La Ruta actual del alumno es: \(self.product.alumno![arrayIndice[filaSeleccionada]].ruta2 ?? ""). En la direccion: \(self.product.alumno![arrayIndice[filaSeleccionada]].direccion2 ?? "") el alumno \(bs) baja solo. "
        }
    }
    

}

