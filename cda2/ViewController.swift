//
//  ViewController.swift
//  cda2
//
//  Created by Emilio Castro on 12/29/19.
//  Copyright © 2019 Emilio Castro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//Variables
    private let dataSourceTipo = ["Familia","Maestro"]
    var TipoAutSelect: String?
    
//Referencias
    @IBOutlet weak var tipoAut: UIPickerView!
    @IBOutlet weak var olvidoPassword: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var usuario: UITextField!
    @IBOutlet weak var btnIngresar: UIButton!
    @IBOutlet weak var background: UIImageView!
    let networkingService = NetworkingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tipoAut.dataSource = self
        tipoAut.delegate = self
        
        background.layer.cornerRadius = 10
        btnIngresar.layer.cornerRadius = 10
        usuario.layer.cornerRadius = 10
        password.layer.cornerRadius = 10
        
        
             createTipoAutSelect()
       
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
   
    }

    func createTipoAutSelect(){
          let tipoAutSelec = UIPickerView()
          tipoAutSelec.delegate = self
          
         print(tipoAutSelec)
      }
    func muestraAlerta(pTitulo: String, pMensaje: String, pAction: String){
   
        let alert = UIAlertController(title: pTitulo, message: pMensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: pAction, style: .cancel, handler: nil))
                     present (alert, animated: true)

        
    }
    
    @IBAction func btnIngresar(_ sender: Any) {
        
        if (usuario.text!.isEmpty){
            muestraAlerta(pTitulo: "Alerta", pMensaje: "Debe ingresar su usuario", pAction: "Aceptar")
        }else {
            muestraAlerta(pTitulo: "Alerta", pMensaje: "haciendo POST", pAction: "Aceptar")
            print("usuario: "+usuario.text!)
            print("Clave: "+password.text!)
            let parameters = ["username": usuario.text!, "password": password.text!,"grant_type":"password"]
            
            networkingService.request(endpoint: "token", parameters: parameters as [String : Any]) { [weak self] (result) in
                switch result {
                case .success(let user): self?.performSegue(withIdentifier: "menuPrincipal", sender: user)
                print(user.access_token)
                case .failure( _):
                    //guard let alert = self?.alertService.alert(message: error.localizedDescription) else { return }
                   // self?.present(alert, animated: true)
                    self!.muestraAlerta(pTitulo: "Alerta", pMensaje: "Error WS ", pAction: "Aceptar")
                }
            }
            
            /*
            let message = Message(message: "username=c206&password=aleman&grant_type=password")
            let postRequest = APIRequest(endpoint: "messages")
            postRequest.save(message, completion: {
                result in switch result {
                case .success(let message):
                    print("The following message has been sent \(message.message)")
                case .failure(let error):
                    print ("An error ocurred \(error)")
                }
                
            })*/
        }
        
        
      
    }
  //  override func prepare(for segue: UIStoryboardSegue, sender: Any?){
   //     if let mainAppVC = segue.destination as? MenuPrincipal, let user = sender as? User {
    //        mainAppVC.user = user
     //   }
   // }
}

// Inicio Codigo para PickerView
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSourceTipo.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       TipoAutSelect = dataSourceTipo[row]
       
   /*     if (TipoAutSelect == "Maestro"){
            btnRecuperaClave.isHidden = false
        }else {
            btnRecuperaClave.isHidden = true
        }*/
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSourceTipo[row]
    }
}
//Fin codigo para Picker View

