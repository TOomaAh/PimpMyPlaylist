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

        guard var langStr = Locale.current.languageCode else { return }
        if (langStr.contains("en")) {
            langStr = langStr + "-US"
        } else if (langStr.contains("fr")) {
            langStr = langStr + "-FR"
        }
        let buildUrl = self.ApiUrl + self.ApiKey + "&language=\(langStr)"+"&query=\(formatFileName)"
        print(buildUrl)
        
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
    
    func getMoviesFromPopular(completion: @escaping (Result<MoviesData, Error>) ->Void){
        
        guard var langStr = Locale.current.languageCode else { return }
        if (langStr.contains("en")) {
            langStr = langStr + "-US"
        } else if (langStr.contains("fr")) {
            langStr = langStr + "-FR"
        }
        let buildUrl = "https://api.themoviedb.org/3/movie/popular?api_key=c56d9d02e006f31014b2f148c564b965&language=\(langStr)&page=1"
        
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
    
    func getMoviesFromTmdbId(tmdb_id:Int,completion: @escaping (Result<TmdbMovie, Error>) ->Void){
        
        guard var langStr = Locale.current.languageCode else { return }
        if (langStr.contains("en")) {
            langStr = langStr + "-US"
        } else if (langStr.contains("fr")) {
            langStr = langStr + "-FR"
        }
        let buildUrl = "https://api.themoviedb.org/3/movie/\(tmdb_id)?api_key=c56d9d02e006f31014b2f148c564b965&language=\(langStr)"
        
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
                let jsonData = try decoder.decode(TmdbMovie.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
            
        }
        dataTask?.resume()
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
    
          

