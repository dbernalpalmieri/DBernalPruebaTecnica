//
//  MenuController.swift
//  DBernalPruebaTecnica
//
//  Created by MacBookMBA1 on 30/03/23.
//

import UIKit

class MenuController: UIViewController {
    
    @IBOutlet weak var labelTitle : UILabel!
    @IBOutlet weak var buttonBluetoothDevices : UIButton!
    @IBOutlet weak var textFieldName : UITextField!
    @IBOutlet weak var textFieldAge : UITextField!
    @IBOutlet weak var buttonSendData : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        SetConfig()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func SetConfig(){
        
        labelTitle.text = "Menu"
        labelTitle.textAlignment = NSTextAlignment.center
        textFieldAge.placeholder = "Age"
        textFieldName.placeholder = "Name"
        
        buttonBluetoothDevices.setTitle("Bluetooth Devices", for: .normal)
        buttonSendData.setTitle("Send Data", for: .normal)
        
        textFieldAge.text = "22"
        textFieldName.text = "Daniel"
    
    }
    

    @IBAction func buttonBluetoothDevicesClic (_ sender : UIButton!){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "bluetoothDevices", sender: self)
        }
    }
    @IBAction func buttonSendDataClic (_ sender : UIButton!){
        guard let age = Int(textFieldAge.text ?? "0"), 1...100 ~= age  else{
            return
        }
        
        guard let name = textFieldName.text else{
            return
        }
        
        let usuarioData = UsuarioData(name: name, age: age)
        
        LoadData(usuarioData)
        
    }

    func LoadData(_ usuarioData : UsuarioData){
        util.viewModel.PostValidateData(usuarioData) { dataResponse, error in
            if let dataResponse = dataResponse, error == nil{
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        // Crear una instancia de UIAlertController con estilo "alert"
                        let alert = UIAlertController(title: dataResponse.respuesta, message: util.desencriptarAES256(cadenaEncriptada: dataResponse.clave, claveSecreta: "FVOTFTs1vGc1UjadBAVNeUKmr2RgHR55"), preferredStyle: .alert)

                        // Crear una acción "OK" para el alert
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)

                        // Agregar la acción "OK" al alert
                        alert.addAction(okAction)

                        // Mostrar el alert en la pantalla
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }else if let error = error{
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        // Crear una instancia de UIAlertController con estilo "alert"
                        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)

                        // Crear una acción "OK" para el alert
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)

                        // Agregar la acción "OK" al alert
                        alert.addAction(okAction)

                        // Mostrar el alert en la pantalla
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }

}
