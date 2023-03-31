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
        
        labelTitle.text = "Login"
        labelTitle.textAlignment = NSTextAlignment.center
        
        textFieldEmail.placeholder = "example@email.com"
        textFieldPassword.placeholder = "*********"
        textFieldPassword.isSecureTextEntry = true
        
        textFieldEmail.text = "daniel@gmail.com"
        textFieldPassword.text = "Hola123*"
        
        buttonLogin.setTitle("Login", for: .normal)
        //KaLXQ/oByzkau5g9ATQfxgBBsDNy22f1WViDPff8oQFyIUHwy58qDkrrBBqEzY9Bsgo2LhA=
//        let x = util.encriptarAES256(cadena: "Recibido Satisfactoriamen", claveSecreta: "FVOTFTs1vGc1UjadBAVNeUKmr2RgHR55")
//        print(x)
//        print(util.desencriptarAES256(cadenaEncriptada: "KaLXQ/oByzkau5g9ATQfxgBBsDNy22f1WViDPff8oQFyIUHwy58qDkrrBBqEzY9Bsgo2LhA=", claveSecreta: "FVOTFTs1vGc1UjadBAVNeUKmr2RgHR55"))
    }
    
    
    @IBAction func buttonLoginClic(_ sender : UIButton!){
        labelError.text = ""
        
        guard let email = textFieldEmail.text else{
            labelError.text = "Type your email"
            return
        }
        guard let password = textFieldPassword.text else{
            labelError.text = "Type your password"
            return
        }
        
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
    }


}

