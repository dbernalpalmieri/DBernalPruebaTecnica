
import Foundation
var util = Utility.sharedInstance

struct Utility{
    
    static let sharedInstance = Utility()
    
    let urlSession = URLSession.shared
    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()
    var urlComponents = URLComponents()
    let loginViewModel = LoginViewModel()
    private init(){
        
    }
    
}
