//
//  ListClaveController.swift
//  DBernalPruebaTecnica
//
//  Created by MacBookMBA1 on 31/03/23.
//

import UIKit

class ListClaveController: UIViewController {
    
    @IBOutlet weak var tableViewClave : UITableView!
    
    var responses = [Response]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SetConfig()
    }
    override func viewWillAppear(_ animated: Bool) {
        responses = util.dataSaveViewModel.GetAllClave()
     
        
        if responses.count == 0{
                // Crear una instancia de UIAlertController con estilo "alert"
            let alert = UIAlertController(title: "No data", message: "Send data first", preferredStyle: .alert)
            
                // Crear una acción "OK" para el alert
            let okAction = UIAlertAction(title: "OK", style: .default) { action in
                self.navigationController?.popViewController(animated: true)
            }
            
                // Agregar la acción "OK" al alert
            alert.addAction(okAction)
            
                // Mostrar el alert en la pantalla
            self.present(alert, animated: true, completion: nil)
        }
        tableViewClave.reloadData()
    }
    
    func SetConfig(){
        tableViewClave.register(ClaveCell.nib, forCellReuseIdentifier: ClaveCell.identifier)
        tableViewClave.delegate = self
        tableViewClave.dataSource = self
        tableViewClave.rowHeight =  UITableView.automaticDimension
    }
    

}
extension ListClaveController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ClaveCell.identifier, for: indexPath) as? ClaveCell else{
            return UITableViewCell()
        }
        
        cell.labelClave.text = responses[indexPath.item].clave
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
}
