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
    
    @IBOutlet weak var pickerParada: UIPickerView!
    @IBOutlet weak var fechaPV: UIDatePicker!
    @IBOutlet weak var datosAlumno: UILabel!
    @IBOutlet weak var datosRutaAlumno: UILabel!
    @IBOutlet weak var pickerAlumno: UIPickerView!
    @IBOutlet weak var pickerRutaRegreso: UIPickerView!
    var filaSeleccionada  = 1
    var totalElementos = 1
    var arrayElementos: [String] = ["-Seleccione un Alumno-"]
    var arrayIndice: [Int] = [-1]
    
    var arrayRutas: [String] = ["-Seleccione uno-"]
    var totalElementosRuta = 1
    var arrayIndiceRuta: [Int] = [-1]
    
    var arrayRutasV: [String] = ["-Seleccione uno-"]
    var totalElementosRutaV = 1
    var arrayIndiceRutaV: [Int] = [-1]
    
    var arrayParadas: [String] = ["-Seleccione uno-"]
    var totalElementosParada = 1
    var arrayIndiceParada: [Int] = [-1]
    
    var arrayAllDirecciones = [-1,"-","-Seleccione uno-"] as [Any]
    
    var esViernes = false
    
    var Arralumno = alumno()
    var Arrrutas = rutas()
    var product = Decodificador()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerAlumno.dataSource = self
        pickerAlumno.delegate = self
        pickerRutaRegreso.dataSource = self
        pickerRutaRegreso.delegate = self
        pickerParada.dataSource = self
        pickerParada.delegate = self
              
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
              //  print(self.product.alumno!.count)
              //  print(self.product.rutas!.count)
                self.totalElementos = self.product.alumno!.count+1
               
                for i in 0...self.product.alumno!.count-1 {
              
                    self.arrayElementos.append(self.product.alumno![i].nombre!)
                    self.arrayIndice.append(i)
                }
                
                var conteo = 0
                var conteov = 0
              //  print("------------ Llenado -------------")
               // print("Total elementos Ruta -> \(self.product.rutas.count)")
               // print("Total Inicial Rutas normal -> \(self.arrayRutas.count)")
               // print("Total Inicial Rutas Viernes -> \(self.arrayRutasV.count)")
                for x in 0...self.product.rutas!.count-1 {
                    
                    if (self.product.rutas![x].Ruta.contains("Viernes")){
                        conteov += 1
                      //  print("Llenando rutas viernes -> \(self.product.rutas![x].Ruta!)")
                         self.arrayRutasV.append(self.product.rutas![x].Ruta!)
                        self.totalElementosRutaV += 1
                        self.arrayIndiceRutaV.append(conteov)
                    }else {
                        conteo += 1
                         self.totalElementosRuta += 1
                      //   print("Llenando rutas normal -> \(self.product.rutas![x].Ruta!)")
                        self.arrayRutas.append(self.product.rutas![x].Ruta!)
                        self.arrayIndiceRuta.append(conteo)
                    }
                   
                  /*  for r in 0...self.product.rutas![x].direcciones.count-1 {
                        print("Para la ruta \(self.product.rutas![x].Ruta!) hay \(self.product.rutas![x].direcciones.count) direcciones ")
                        print("Codigo: \(self.product.rutas![x].direcciones![r].codDireccion!)")
                        print("Direccion: \(self.product.rutas![x].direcciones![r].Direccion!)")
                        //arrayAllDirecciones.append(x,self.product.rutas![x].direcciones[r].codDireccion,self.product.rutas![x].direcciones[r].Direccion)
                       
                        
                    }*/
               
                }
             //   print("Total Rutas normal -> \(self.arrayRutas.count)")
             //   print("Total Rutas Viernes -> \(self.arrayRutasV.count)")
              //   print("------- Fin llenado --------")
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
        
        if (pickerView.tag == 1){
            return totalElementos}
        else if (pickerView.tag == 2) {
                return totalElementosRuta
            
        }else {return totalElementosParada }
       }
       
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

     // print ("Total Array Rutas -> \(arrayRutas.count)")
      //print ("Es viernes en tl titleForRow -> \(esViernes)")
        if (pickerView.tag == 1){
            //print ("Valor de row tag1 -> \(row)")
            
            return arrayElementos[row]
            
        }
        else if (pickerView.tag == 2 ) {
           // print("numero de tag -> \(pickerView.tag)")
                if (esViernes) {
                        //  print ("Valor de row Viernes -> \(row)")
                          return arrayRutasV[row]}
                else{
                     // print ("Valor de row Normal -> \(row)")
                        return arrayRutas[row]
                
                 }
        } else {return arrayParadas[row]}
       }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       // print("Elemento seleccionado -> \(arrayElementos[row].description)")
       // print("Elemento con Indice -> \(arrayIndice[row].description)")
        
        
        if (pickerView.tag == 1) {
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
            
        }else if (pickerView.tag == 2) {
            print ("Codigo para Rutas....")
            var buscandoRuta = ""
            for r in 0...product.rutas.count-1 {
                
                if (esViernes){buscandoRuta = arrayRutasV[row].description}
                else {buscandoRuta = arrayRutas[row].description}
                
                if (self.product.rutas[r].Ruta == buscandoRuta){
                    print("Encontrò las direcciones de la Ruta ")
                for p in 0...self.product.rutas![r].direcciones.count-1 {
                    
                    
                                       print("Para la ruta \(self.product.rutas![r].Ruta!) hay \(self.product.rutas![r].direcciones.count) direcciones ")
                                    //   print("Codigo: \(self.product.rutas![r].direcciones![p].codDireccion!)")
                                     //  print("Direccion: \(self.product.rutas![r].direcciones![p].Direccion!)")
                    arrayParadas.append(self.product.rutas![r].direcciones![p].Direccion!)
                                      
                                       
                }
                    print("Total Direcciones Almacenadas -> \(self.product.rutas![r].direcciones.count+1)")
                    totalElementosParada = self.product.rutas![r].direcciones.count+1
                }
            }
            pickerParada.reloadAllComponents()
            
            
        }else {print ("Codigo para PAradas...")}
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
            self.esViernes = false
        }else {
            self.esViernes = true
              datosRutaAlumno.text = "La Ruta actual del alumno es: \(self.product.alumno![arrayIndice[filaSeleccionada]].ruta2 ?? ""). En la direccion: \(self.product.alumno![arrayIndice[filaSeleccionada]].direccion2 ?? "") el alumno \(bs) baja solo. "
        }
        self.pickerRutaRegreso.reloadAllComponents()
    }
    

}

