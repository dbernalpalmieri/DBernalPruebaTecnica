

import Foundation
import CoreData


struct DataSaveViewModel{
    func AddClave(_ clave : String) -> Bool{
        do {
            let newFavorite = NSEntityDescription.insertNewObject(forEntityName: "Response", into: util.context)
            newFavorite.setValue(clave, forKey: "clave")
            try util.context.save()
            return true
        } catch _ as NSError{
            return false
        }
    }
    
    func GetAllClave() -> [Response] {
        
        let request = NSFetchRequest<Response>(entityName: "Response")
        
        var claves: [Response] = []
        do {
            claves = try util.context.fetch(request)
        } catch {
            print("Error al obtener registros: \(error)")
        }
        
        return claves
    }
}
