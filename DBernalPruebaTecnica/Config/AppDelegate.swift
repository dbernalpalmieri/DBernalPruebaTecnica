//
//  AppDelegate.swift
//  DBernalPruebaTecnica
//
//  Created by MacBookMBA1 on 30/03/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var inactivityTimer: Timer?
    let inactivityDuration: TimeInterval = 5 // Duración de inactividad deseada en segundos (3 minutos)
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Desactivar el temporizador de inactividad cuando el usuario interactúa con la aplicación
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(resetInactivityTimer))
        window?.addGestureRecognizer(tapGesture)
        // Iniciar temporizador de inactividad
        startInactivityTimer()
        
        return true
    }
    
    @objc func resetInactivityTimer() {
        // Restablecer el temporizador de inactividad al ser interactuado
        inactivityTimer?.invalidate()
        startInactivityTimer()
    }
    
    func startInactivityTimer() {
        // Iniciar temporizador de inactividad
        inactivityTimer = Timer.scheduledTimer(withTimeInterval: inactivityDuration, repeats: false) { [weak self] _ in
            // Redireccionar al LoginViewController después de la duración de inactividad
            print("Ya paso el tiempo ")
            self?.resetInactivityTimer()
           
        }
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

