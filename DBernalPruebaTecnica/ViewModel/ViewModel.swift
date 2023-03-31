import Foundation



struct ViewModel{
    func PostAuthorization(_ usuario : Usuario, _ response : @escaping(Authentication?, Error?) -> Void){
        util.urlComponents.scheme = "https"
        util.urlComponents.host = "93fa5164-917a-42c3-a649-612a34551337.mock.pstmn.io"
        util.urlComponents.path = "/Authentication/Login"
        
        if let url = util.urlComponents.url {
            do{
                util.jsonEncoder.outputFormatting = .prettyPrinted
                
                let jsonBodyData = try util.jsonEncoder.encode(usuario)
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = jsonBodyData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                util.urlSession.dataTask(with: request) { data, res, error in
                    
                    if let data = data, let httpResponse = res as? HTTPURLResponse, error == nil{
                        if 200...400 ~=  httpResponse.statusCode {
                            do{
                                let resData = try util.jsonDecoder.decode(Authentication.self, from: data)
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
    func PostValidateData(_ usuarioData : UsuarioData, _ response : @escaping(DataResponse?, Error?) -> Void){
            util.urlComponents.scheme = "https"
            util.urlComponents.host = "93fa5164-917a-42c3-a649-612a34551337.mock.pstmn.io"
            util.urlComponents.path = "/Validate"
            
            if let url = util.urlComponents.url {
                do{
                    util.jsonEncoder.outputFormatting = [ .prettyPrinted]
                    
//                    let json: [String: String] = ["name": "Daniel",
//                                               "age" : "20"]
                    
                   // let jsonBodyData = try JSONSerialization.data(withJSONObject: json)
                    let jsonBodyData = try util.jsonEncoder.encode(usuarioData)
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

                    request.httpBody = jsonBodyData
                  
                    
                    util.urlSession.dataTask(with: request) { data, res, error in
                        
                        if let data = data, let httpResponse = res as? HTTPURLResponse, error == nil{
                            print(httpResponse.statusCode)
                            if 200...400 ~=  httpResponse.statusCode {
                                do{
                                    let resData = try util.jsonDecoder.decode(DataResponse.self, from: data)
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
