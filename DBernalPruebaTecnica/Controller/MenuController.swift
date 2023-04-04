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
    
    @IBOutlet weak var buttonListClaves : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        SetConfig()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
    }
    
    func SetConfig(){
        navigationItem.hidesBackButton = true
        labelTitle.text = "Menu"
        labelTitle.textAlignment = NSTextAlignment.center
        textFieldAge.placeholder = "Age"
        textFieldAge.text = ""
        textFieldAge.keyboardType = .numberPad
        textFieldAge.delegate = self
        
        textFieldName.keyboardType = .asciiCapable
        textFieldName.text = ""
        textFieldName.placeholder = "Name"
        textFieldName.delegate = self
        
        buttonBluetoothDevices.setTitle("Bluetooth Devices", for: .normal)
        buttonSendData.setTitle("Send Data", for: .normal)
        buttonListClaves.setTitle("Claves", for: .normal)
        
       
    
    }
    
    @IBAction func buttonListClaves(_ sender : UIButton){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "listClaves", sender: self)
        }
    }
    

    @IBAction func buttonBluetoothDevicesClic (_ sender : UIButton!){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "bluetoothDevices", sender: self)
        }
    }
    @IBAction func buttonSendDataClic (_ sender : UIButton!){
        guard let age = textFieldAge.text  else{
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
                        
                        if util.dataSaveViewModel.AddClave(dataResponse.clave){
                            print("Save..")
                        }
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
extension MenuController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Evitamos el doble espacio
        if string == " " {
            // Revisamos si ya hay un espacio antes
            if let lastCharacter = textField.text?.last, lastCharacter == " " {
                // Si ya existe el espacio regresamos para evitar insertar otro
                return false
            }
        }
        if textField == self.textFieldName{
            let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            
            let allowedCharacters = CharacterSet.letters.union(CharacterSet(charactersIn: " "))
            let maxLength = 35
            
            // Revisar caracteres
            guard newText.rangeOfCharacter(from: allowedCharacters.inverted) == nil else {
                return false
                
            }
            return newText.count <= maxLength
        }
        if textField == self.textFieldAge{
            // Limitar la entrada a dos caracteres numéricos
            guard let currentText = textField.text,
                  let range = Range(range, in: currentText) else {
                return true
            }
            let newText = currentText.replacingCharacters(in: range, with: string)
            let isNumeric = newText.isEmpty || (Int(newText) != nil)
            let isUnderTwoCharacters = newText.count <= 2
            return isNumeric && isUnderTwoCharacters
        }
        
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case self.textFieldName:
                self.textFieldAge.becomeFirstResponder()
            default:
                textField.resignFirstResponder()
        }
            //self.view.endEditing(true)
        
        return true
    }
}
