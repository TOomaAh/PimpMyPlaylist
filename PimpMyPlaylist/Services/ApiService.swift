//
//  ApiService.swift
//  PimpMyPlaylist
//
//  Created by Anthony Jauch on 17/01/2021.
//

import Foundation

class ApiService {
    
   // private var url: URL
    private var ApiKey: String
    private var dataTask: URLSessionDataTask?
    private var ApiUrl: String
    
    init() {
        self.ApiUrl = "http://api.themoviedb.org/3/search/movie?api_key="
        self.ApiKey = "c56d9d02e006f31014b2f148c564b965"
    
    }
    
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    
    func getMoviesFromResearch(filmName: String, completion: @escaping (Result<MoviesData, Error>) ->Void){
       let formatFileName = filmName.replacingOccurrences(of: " ", with: "%20")
        
        let buildUrl = self.ApiUrl + self.ApiKey + "&query=\(formatFileName)"
        
        guard let requestUrl = URL(string: buildUrl ) else {
            fatalError("Error while building url")
        }
        
        dataTask = URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            
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
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
            
        }
        dataTask?.resume()
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

    
    func getAllMovie(completion: @escaping(Result<WatchListMovieData,Error>) -> Void) {
        let idFile = getDocumentsDirectory().appendingPathComponent("id.txt")
        let id = try! String(contentsOf: idFile)
        
        
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
        
        dataTask = URLSession.shared.dataTask(with: ressourceUrl) { (data, response, error) in
            
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
                
                do{
                    completion(.success(movieId))
                } catch {
                    completion(.failure(error))
                }
        }
            dataTask.resume()
    }
    

    
    func updateMovie(movie:WatchListMovie,completion: @escaping (Result<WatchListMovie, Error>) -> Void){
        let stringUrl = "https://strapi.brunet.ovh/movies/\(movie.id!)"
        guard let ressourceUrl = URL(string: stringUrl) else {
            fatalError("Error while building url")
        }
        
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
            
            var updatedMovie = WatchListMovie(id: movie.id!, title: movie.title, description: movie.description, tmdb_id: movie.tmdb_id, watched: status, date: movie.date)
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
    
          

