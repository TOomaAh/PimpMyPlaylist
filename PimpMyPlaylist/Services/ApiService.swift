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
    
    func postMovie(movie:TmdbMovie,user:User,completion: @escaping (Result<WatchListMovie, Error>) -> Void){
        let stringUrl = "https://strapi.brunet.ovh/movies"
        guard let ressourceUrl = URL(string: stringUrl) else {
            fatalError("Error while building url")
        }
        
        do{
            var urlRequest = URLRequest(url: ressourceUrl)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            print(user.jwt)
            urlRequest.setValue("Bearer \(String(describing: user.jwt))", forHTTPHeaderField: "Authorization")
            
            
            let formatDate = movie.release_date
             let dateFormatter = DateFormatter()
             dateFormatter.dateFormat="yyyy-MM-dd"
             let dateString = dateFormatter.date(from: formatDate)
             let dateTimeStamp  = dateString!.timeIntervalSince1970
             let todayDate = Date()
    
            let todayDateFormat = dateFormatter.string(from: todayDate)
            
         /*   let watchlistMovie = WatchListMovie(title: movie.title, tmdb_id: movie.id, watched: false, year: Int(dateTimeStamp))
        */
            let watchlistMovie = WatchListMovie(title: movie.title, description: movie.overview, tmdb_id: movie.id, watched: false, users: user.id, date: todayDateFormat)
            
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
                    let postMovie = try JSONDecoder().decode(WatchListMovie.self, from: jsonData)
                    
                    print(String(data: data!,encoding:.utf8))
                    completion(.success(postMovie))
                } catch {
                    completion(.failure(error))
                }
        }
            dataTask.resume()
    }
  }*/
    
    func getAllMovie(completion: @escaping(Result<[WatchListMovie],Error>) -> Void) {
        
        let stringUrl = "https://strapi.brunet.ovh/movies"
        guard let ressourceUrl = URL(string: stringUrl) else {
            fatalError("Error while building url")
        }
        var urlRequest = URLRequest(url: ressourceUrl)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjEyMDE4OTQ2LCJleHAiOjE2MTQ2MTA5NDZ9.dnhC1kvhb7lGKo8apan8H9NEGGIjgZlh3Cs73dCssAA", forHTTPHeaderField: "Authorization")
        
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
                let jsonData = try decoder.decode([WatchListMovie].self, from: data)
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
        
        let stringUrl = "http://127.0.0.1:1234/movies/\(id)"
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
        let stringUrl = "http://127.0.0.1:1234/movies/\(id)"
        guard let ressourceUrl = URL(string: stringUrl) else {
            fatalError("Error while building url")
        }
        
        do{
            var urlRequest = URLRequest(url: ressourceUrl)
            urlRequest.httpMethod = "DELETE"
            
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
            print("Deleted succesfully film with id = \(id)" )
    }
  }
    
    
    func connectUser(user:User,completion: @escaping (Result<UserLogin, Error>) -> Void){
        let stringUrl = "https://strapi.brunet.ovh/auth/local/"
        guard let ressourceUrl = URL(string: stringUrl) else {
            fatalError("Error while building url")
        }
        
        do{
            var urlRequest = URLRequest(url: ressourceUrl)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

            let user = UserLogin(identifier: user.email, password: user.password)
            
            
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
                    let postUser = try JSONDecoder().decode(UserLogin.self, from: jsonData)
                    print(postUser)
                    completion(.success(postUser))
                } catch {
                    completion(.failure(error))
                }
        }
            dataTask.resume()
    }
  }

    
   /* func updateMovie(movie:WatchListMovie,completion: @escaping (Result<WatchListMovie, Error>) -> Void){
        let stringUrl = "http://127.0.0.1:1234/movies/\(movie.id!)"
        guard let ressourceUrl = URL(string: stringUrl) else {
            fatalError("Error while building url")
        }
        
        do{
            var urlRequest = URLRequest(url: ressourceUrl)
            urlRequest.httpMethod = "PUT"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            var status = movie.watched
            if status == true {
                status = false
            } else if status == false {
                status = true
            }
            
            let updatedMovie = WatchListMovie(id: movie.id, title: movie.title, tmdb_id: movie.tmdb_id, watched: status, year: movie.year)
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
  }*/
    
}
    
          

