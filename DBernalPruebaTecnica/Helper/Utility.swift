
import Foundation
import CryptoKit

var util = Utility.sharedInstance

struct Utility{
    
    static let sharedInstance = Utility()
    
    let urlSession = URLSession.shared
    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()
    var urlComponents = URLComponents()
    let viewModel = ViewModel()
    private init(){
        
    }

    // Función para encriptar una cadena usando AES256
    // Función para encriptar una cadena de texto
    func encriptarAES256(cadena: String, claveSecreta: String) -> String? {
        guard let claveData = claveSecreta.data(using: .utf8) else {
            return nil
        }

        let clave = SymmetricKey(data: claveData)
        let nonce = AES.GCM.Nonce()

        do {
            let cifrado = try AES.GCM.seal(cadena.data(using: .utf8)!, using: clave, nonce: nonce)
            let cifradoData = cifrado.combined
            let cifradoBase64 = cifradoData!.base64EncodedString()
            return cifradoBase64
        } catch {
            return nil
        }
    }

    
    // Función para desencriptar una cadena de texto
    func desencriptarAES256(cadenaEncriptada: String, claveSecreta: String) -> String? {
        guard let claveData = claveSecreta.data(using: .utf8),
              let cifradoData = Data(base64Encoded: cadenaEncriptada) else {
            return nil
        }

        let clave = SymmetricKey(data: claveData)

        do {
            let cifrado = try AES.GCM.SealedBox(combined: cifradoData)
            let desencriptado = try AES.GCM.open(cifrado, using: clave)
            let cadenaDesencriptada = String(data: desencriptado, encoding: .utf8)
            return cadenaDesencriptada
        } catch {
            return nil
        }
    }


}
