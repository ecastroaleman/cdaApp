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
    var token = "";
    
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
        }else if (password.text!.isEmpty) {
             muestraAlerta(pTitulo: "Alerta", pMensaje: "Debe ingresar su contraseña", pAction: "Aceptar")
        }else {
            
            
            let parameters = ["username": usuario.text!, "password": password.text!,"grant_type":"password"]
            
            networkingService.request(endpoint: "token", parameters: parameters as [String : Any]) { [weak self] (result) in
                switch result {
                    
                case .success(let user):
                    self!.token = user.access_token
                    self?.performSegue(withIdentifier: "menuPrincipal", sender: user)
                case .failure(let error):
                    var retorno = ""
                    if (error.localizedDescription == "invalid_grant"){
                        retorno = "Usuario y Password Invalidos"
                    }else {retorno = error.localizedDescription}
                    
                    self!.muestraAlerta(pTitulo: "Alerta", pMensaje: retorno, pAction: "Aceptar")
                    return
                }
                
            }//fin networking
                     
        } //fin else
        
    } //fin btn_Ingresar
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
         
         if segue.identifier == "menuPrincipal" {
         let vc = segue.destination as! MenuPrincipal
             vc.token = token
         }
     }
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
       
        if (TipoAutSelect == "Maestro"){
            olvidoPassword.isHidden = false
        }else {
            olvidoPassword.isHidden = true
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSourceTipo[row]
    }
}
//Fin codigo para Picker View

