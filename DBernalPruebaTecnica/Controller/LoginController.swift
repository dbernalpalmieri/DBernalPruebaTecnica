//
//  ViewController.swift
//  DBernalPruebaTecnica
//
//  Created by MacBookMBA1 on 30/03/23.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var labelTitle : UILabel!
    @IBOutlet weak var textFieldEmail : UITextField!
    @IBOutlet weak var textFieldPassword : UITextField!
    @IBOutlet weak var buttonLogin : UIButton!
    @IBOutlet weak var labelError : UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        SetConfig()
    }
    
    func SetConfig(){
        labelError.text = ""
        labelError.textColor = .red
        labelError.textAlignment = .center
        
        labelTitle.text = "Login"
        labelTitle.textAlignment = NSTextAlignment.center
        
        textFieldEmail.text = ""
        textFieldEmail.placeholder = "example@email.com"
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.delegate = self
        
        textFieldPassword.keyboardType = .default
        textFieldPassword.text = ""
        textFieldPassword.placeholder = "*********"
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.delegate = self
        
        
        buttonLogin.setTitle("Login", for: .normal)
        
//        let x = util.encriptarAES256(cadena: "Recibido Satisfactoriamente", claveSecreta: "FVOTFTs1vGc1UjadBAVNeUKmr2RgHR55")
//        print(x)
    }
    
    
    @IBAction func buttonLoginClic(_ sender : UIButton!){
        labelError.text = ""
       
        
        guard let email = textFieldEmail.text, !email.isEmpty, email != "" else{
            labelError.text = "Type your email"
            return
        }
        guard let password = textFieldPassword.text, !password.isEmpty, password != "" else{
            labelError.text = "Type your password"
            return
        }
        buttonLogin.isEnabled = false
        let usuario =  Usuario(email: email, password: password)
        
        ValidateLogin(usuario)
    }
    
    func ValidateLogin(_ usuario : Usuario){
      
        util.viewModel.PostAuthorization(usuario) { login, error in
            if let login = login, error == nil{
                if login.status{
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "menu", sender: self)
                    }
                    
                }else{
                    DispatchQueue.global(qos: .background).async {
                        DispatchQueue.main.async {
                            self.labelError.text = "Invalid credentials."
                        }
                    }
                }
            }else if let error = error{
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        self.labelError.text = error.localizedDescription
                    }
                }
            }
        }
        self.buttonLogin.isEnabled = true
    }


}
extension LoginController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case self.textFieldEmail:
                self.textFieldPassword.becomeFirstResponder()
            default:
                textField.resignFirstResponder()
        }
            //self.view.endEditing(true)

        return true
    }
}

