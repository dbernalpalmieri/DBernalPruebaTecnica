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
        cell.labelIdentifier.text = peripheral.identifier.uuidString
        
        return cell
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
            tableViewDevices.reloadData()
        }
    }
    
    
}
