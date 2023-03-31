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
    
    @IBOutlet weak var tableViewDevices : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        SetConfig()
    }
    
    func SetConfig(){
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
}
extension ListBluetoothDevicesController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    
}

extension ListBluetoothDevicesController : UITableViewDelegate{
    
}
extension ListBluetoothDevicesController : CBCentralManagerDelegate{
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: nil)
        }
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            peripherals.append(peripheral)
            tableView.reloadData()
        }
    }
    
    
}
