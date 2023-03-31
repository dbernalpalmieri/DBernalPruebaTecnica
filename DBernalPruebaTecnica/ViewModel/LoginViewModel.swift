import Foundation



struct LoginViewModel{
    func PostAuthorization(_ usuario : Usuario, _ response : @escaping(Login?, Error?) -> Void){
        util.urlComponents.scheme = "https"
        util.urlComponents.host = "c3e09b62-462f-46bb-af52-ffa354627cca.mock.pstmn.io"
        util.urlComponents.path = "/Login"
        
        if let url = util.urlComponents.url {
            
            do{
                util.jsonEncoder.outputFormatting = .prettyPrinted
                
                let jsonBodyData = try util.jsonEncoder.encode(usuario)
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = jsonBodyData
                request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                
                util.urlSession.dataTask(with: request) { data, res, error in
                    
                    if let data = data, let httpResponse = res as? HTTPURLResponse, error == nil{
                        if 200...400 ~=  httpResponse.statusCode {
                            do{
                                let resData = try util.jsonDecoder.decode(Login.self, from: data)
                                response(resData, error)
                            }catch let error{
                                response(nil, error)
                            }
                            
                        }
                    }else if let error = error{
                        response(nil, error)
                    }
                    else{
                        response(nil, nil)
                    }
                }.resume()
                
                
            }catch let error{
                response(nil, error)
            }
            
            
        }
    }
}
