//
//  ListBluetoothDevicesController.swift
//  DBernalPruebaTecnica
//
//  Created by MacBookMBA1 on 30/03/23.
//

import UIKit
import CoreBluetooth


class ListBluetoothDevicesController: UIViewController {
    
    var centralManager: CBCentralManager!
    var peripherals = [CBPeripheral]()
    var range = 900.0 // Rango en metros
    
    @IBOutlet weak var tableViewDevices : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        SetConfig()
    }
    
    func SetConfig(){
        navigationController?.isNavigationBarHidden = false
        centralManager = CBCentralManager(delegate: self, queue: nil)
        tableViewDevices.register(DeviceCell.nib, forCellReuseIdentifier: DeviceCell.identifier)
        tableViewDevices.delegate = self
        tableViewDevices.dataSource = self
        tableViewDevices.rowHeight = UITableView.automaticDimension
    }
}
extension ListBluetoothDevicesController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DeviceCell.identifier, for: indexPath) as? DeviceCell else{
            return UITableViewCell()
        }
        let peripheral = peripherals[indexPath.row]
        cell.labelDeviceName.text = peripheral.name ?? "Unknown"
        cell.labelIdentifier.text = "\(peripheral.identifier.uuidString) (\(peripheral.rssi ?? 0) dBm)"
        cell.labelIdentifier.numberOfLines = 0
        
        
        return cell
    }
    
    
}

extension ListBluetoothDevicesController : UITableViewDelegate{
    
}
extension ListBluetoothDevicesController : CBCentralManagerDelegate{
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            let scanOptions = [CBCentralManagerScanOptionAllowDuplicatesKey: false]
            centralManager.scanForPeripherals(withServices: nil, options: scanOptions)
        }else{
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                        // Crear una instancia de UIAlertController con estilo "alert"
                    let alert = UIAlertController(title: "Bluetooth OFF", message: "Power on Bluetooth", preferredStyle: .alert)
                    
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
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if RSSI.doubleValue < range, let name = peripheral.name {
            if !peripherals.contains(peripheral) {
                peripherals.append(peripheral)
            }
        }
        tableViewDevices.reloadData()
    }
    
    
    
}
