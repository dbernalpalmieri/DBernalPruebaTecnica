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
    
    func SetConfig(){
        navigationController?.isNavigationBarHidden = true
        labelTitle.text = "Menu"
        labelTitle.textAlignment = NSTextAlignment.center
        textFieldAge.placeholder = "Age"
        textFieldName.placeholder = "Name"
        
        buttonBluetoothDevices.setTitle("Bluetooth Devices", for: .normal)
        buttonSendData.setTitle("Send Data", for: .normal)
    
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
        
        
        let usuario = Usuario(email: "", password: "", name: name, age: age)

        
    }
    

}
