//
//  WatchListService.swift
//  PimpMyPlaylist
//
//  Created by Anthony Jauch on 18/02/2021.
//

import Foundation

class WatchListService {
    private var dataTask: URLSessionDataTask?

    
    
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func postMovie(movie:TmdbMovie,userId:Int,completion: @escaping (Result<WatchListMovie, Error>) -> Void){
        let stringUrl = "https://strapi.brunet.ovh/movies"
        guard let ressourceUrl = URL(string: stringUrl) else {
            fatalError("Error while building url")
        }
        let tokenFile = getDocumentsDirectory().appendingPathComponent("token.txt")
        let apiToken = try! String(contentsOf: tokenFile)
        
            var urlRequest = URLRequest(url: ressourceUrl)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("Bearer \(String(describing: apiToken))", forHTTPHeaderField: "Authorization")
        
            
            
             let dateFormatter = DateFormatter()
             dateFormatter.dateFormat="yyyy-MM-dd"

             let todayDate = Date()
    
            let todayDateFormat = dateFormatter.string(from: todayDate)
            
        let watchlistMovie = WatchListMovie(title: movie.title, description: movie.overview, tmdb_id: movie.id, watched: false, users_permissions_user: userId, date: todayDateFormat)
            
            let jsonData =  try! JSONEncoder().encode(watchlistMovie)
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
                  

                    let postMovie = try JSONDecoder().decode(WatchListMovie.self, from: data!)
                    completion(.success(postMovie))
                } catch {
                    completion(.failure(error))
                }
        }
            dataTask.resume()
    }
    
    
    func getAllMovie(id:String, completion: @escaping(Result<WatchListMovieData,Error>) -> Void) {
            
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
                let jsonData = try decoder.decode(WatchListMovieData.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    func getMovieById(id: Int,completion: @escaping(Result<WatchListMovie,Error>) -> Void){
        
        let stringUrl = "https://strapi.brunet.ovh/movies/\(id)"
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
                let jsonData = try decoder.decode(WatchListMovie.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
        
    }
    
    func deleteMovie(id:Int) -> Void{
        let stringUrl = "https://strapi.brunet.ovh/movies/\(id)"
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
    
    
    func updateUserMovie(movieId:[Int],completion: @escaping (Result<[Int], Error>) -> Void){
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
        
            let updateId = UpdateWatchListMovie(movies: movieId)
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
                    completion(.success(movieId))
        }
            dataTask.resume()
    }
    
    func updateMovie(movie:WatchListMovie,completion: @escaping (Result<WatchListMovie, Error>) -> Void){
        let stringUrl = "https://strapi.brunet.ovh/movies/\(movie.id!)"
        guard let ressourceUrl = URL(string: stringUrl) else {
            fatalError("Error while building url")
        }
        
        let idFile = getDocumentsDirectory().appendingPathComponent("id.txt")
        let Id = try! String(contentsOf: idFile)
        let  userId = Int(Id)
        
        
        let tokenFile = getDocumentsDirectory().appendingPathComponent("token.txt")
        let apiToken = try! String(contentsOf: tokenFile)
        
        
        do{
            var urlRequest = URLRequest(url: ressourceUrl)
            urlRequest.httpMethod = "PUT"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("Bearer \(String(describing: apiToken))", forHTTPHeaderField: "Authorization")
            
            var status = movie.watched
            if status == true {
                status = false
            } else if status == false {
                status = true
            }
            
            var updatedMovie = WatchListMovie(id: movie.id!, title: movie.title, description: movie.description, tmdb_id: movie.tmdb_id, watched: status,users_permissions_user: userId, date: movie.date)
            updatedMovie.id = updatedMovie.id!
            
            let jsonData =  try! JSONEncoder().encode(updatedMovie)
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
                    let postMovie = try JSONDecoder().decode(WatchListMovie.self, from: jsonData)
                    completion(.success(postMovie))
                } catch {
                    completion(.failure(error))
                }
        }
            dataTask.resume()
    }
        
  }
    

}
