//
//  UserService.swift
//  PimpMyPlaylist
//
//  Created by Anthony Jauch on 18/02/2021.
//

import Foundation

class UserService {
    private var dataTask: URLSessionDataTask?
    
    
    func connectUser(identifier:String, password:String,completion: @escaping (Result<Connect, Error>) -> Void){
        let stringUrl = "https://strapi.brunet.ovh/auth/local/"
        guard let ressourceUrl = URL(string: stringUrl) else {
            fatalError("Error while building url")
        }
        do{
            var urlRequest = URLRequest(url: ressourceUrl)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let user = UserLogin(identifier: identifier, password: password)
            
            
            let jsonData =  try! JSONEncoder().encode(user)
            urlRequest.httpBody = jsonData
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard (response as? HTTPURLResponse) != nil else {
                    return
                }
                
                guard data != nil else{
                    return
                }
                
                do{
                    let postUser = try JSONDecoder().decode(Connect.self, from: data!)
                    completion(.success(postUser))
                } catch {
                    completion(.failure(error))
                }
        }
            dataTask.resume()
    }
  }
    
    func registerUser(username:String,email:String, password:String,completion: @escaping (Result<Connect, Error>) -> Void){
        let stringUrl = "https://strapi.brunet.ovh/auth/local/register"
        guard let ressourceUrl = URL(string: stringUrl) else {
            fatalError("Error while building url")
        }
        do{
            var urlRequest = URLRequest(url: ressourceUrl)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let user = RegisterUser(username: username, email: email, password: password, confirmed: true, blocked: false)
            
            
            let jsonData =  try! JSONEncoder().encode(user)
            urlRequest.httpBody = jsonData
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard (response as? HTTPURLResponse) != nil else {
                    return
                }
                
                guard data != nil else{
                    return
                }
                
                do{
                    let postUser = try JSONDecoder().decode(Connect.self, from: data!)
                    completion(.success(postUser))
                } catch {
                    completion(.failure(error))
                }
        }
            dataTask.resume()
    }
  }
    
    
}
