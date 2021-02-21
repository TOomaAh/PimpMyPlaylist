//
//  FriendService.swift
//  PimpMyPlaylist
//
//  Created by Anthony Jauch on 18/02/2021.
//

import Foundation

class FriendService {
    private var dataTask: URLSessionDataTask?
    
    func getAllFriends(id:String, completion: @escaping(Result<ArrayFriend,Error>) -> Void) {
            
        let stringUrl = "https://strapi.brunet.ovh/users/\(String(describing: id))"
        guard let ressourceUrl = URL(string: stringUrl) else {
            fatalError("Error while building url")
        }
        
        let tokenFile = getDocumentsDirectory().appendingPathComponent("token.txt")
        let apiToken = try! String(contentsOf: tokenFile)
        
        var urlRequest = URLRequest(url: ressourceUrl)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(String(describing: apiToken))", forHTTPHeaderField: "Authorization")
        
        dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask: error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else{
                print("Empty Data")
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ArrayFriend.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    func updateFriends(friendsId:[Int],completion: @escaping (Result<[Int], Error>) -> Void){
        let idFile = getDocumentsDirectory().appendingPathComponent("id.txt")
        let id = try! String(contentsOf: idFile)
        
        let stringUrl = "https://strapi.brunet.ovh/users/\(id)"
        guard let ressourceUrl = URL(string: stringUrl) else {
            fatalError("Error while building url")
        }
        let tokenFile = getDocumentsDirectory().appendingPathComponent("token.txt")
        let apiToken = try! String(contentsOf: tokenFile)
        
            var urlRequest = URLRequest(url: ressourceUrl)
            urlRequest.httpMethod = "PUT"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("Bearer \(String(describing: apiToken))", forHTTPHeaderField: "Authorization")
        
            let updateId = UpdateFriend(friends: friendsId)
            let jsonData =  try! JSONEncoder().encode(updateId)
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

                    completion(.success(friendsId))
        }
            dataTask.resume()
    }
    
    func deleteFriend(id:Int) -> Void{
        let stringUrl = "https://strapi.brunet.ovh/users/?friends\(id)"
        guard let ressourceUrl = URL(string: stringUrl) else {
            fatalError("Error while building url")
        }
   
        
        let tokenFile = getDocumentsDirectory().appendingPathComponent("token.txt")
        let apiToken = try! String(contentsOf: tokenFile)
        
        var urlRequest = URLRequest(url: ressourceUrl)
        urlRequest.httpMethod = "DELETE"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(String(describing: apiToken))", forHTTPHeaderField: "Authorization")
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                if let error = error {
                    print("DataTask: error: \(error.localizedDescription)")
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Empty Response")
                    return
                }
                print("Response status code: \(response.statusCode)")
                
                guard data != nil else{
                    print("Empty Data")
                    return
                }
        }
            dataTask.resume()
  }
    
    func getUserFromResearch(username: String, completion: @escaping (Result<[User], Error>) ->Void){
        
    
        let buildUrl = "https://strapi.brunet.ovh/users/?username=\(username)"
        
        guard let requestUrl = URL(string: buildUrl ) else {
            fatalError("Error while building url")
        }
        
        let tokenFile = getDocumentsDirectory().appendingPathComponent("token.txt")
        let apiToken = try! String(contentsOf: tokenFile)
        
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(String(describing: apiToken))", forHTTPHeaderField: "Authorization")
        
        dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask: error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else{
                print("Empty Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                //let str = String(decoding: data, as: UTF8.self)
                let jsonData = try decoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
            
        }
        dataTask?.resume()
    }
    

}
