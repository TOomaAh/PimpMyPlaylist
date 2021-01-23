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
    
    func fetchMovie (filmTitle: String)->Void{
        var movieArray = [Movie]()
        self.getMoviesFromResearch(filmName: filmTitle) { [self] (result) in
            switch result {
            case .success(let movie):
                for movieInfo in movie.movies {
                    let resultMovie = Movie(tmdb_id: movieInfo.id, original_title: movieInfo.title, overview: movieInfo.overview, genre_id: movieInfo.genreIds, popularity: movieInfo.rate, date: movieInfo.year)
                    print(resultMovie.getTitle())
                    print(resultMovie.getOverview())
                    print(resultMovie.getTmdb_id())
                    movieArray.append(resultMovie)
                }
                //print(movieArray[0].getTitle())
                break
            case .failure(let e):
                print(e)
                break
            }
        }
    }

    func postMovie(movie:Movie,completion: @escaping (Result<WatchListMovie, Error>) -> Void){
        let stringUrl = "http://127.0.0.1:1234/movies"
        guard let ressourceUrl = URL(string: stringUrl) else {
            fatalError("Error while building url")
        }
        
        do{
            var urlRequest = URLRequest(url: ressourceUrl)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let formatDate = movie.getDate()
             let dateFormatter = DateFormatter()
             dateFormatter.dateFormat="yyyy-MM-dd"
             let dateString = dateFormatter.date(from: formatDate)
             let dateTimeStamp  = dateString!.timeIntervalSince1970
            
            let watchlistMovie = WatchListMovie(title: movie.getTitle(), tmdb_id: movie.getTmdb_id(), watched: false, year: Int(dateTimeStamp))
            
            let jsonData =  try! JSONEncoder().encode(watchlistMovie)
            urlRequest.httpBody = jsonData
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
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
                    let postMovie = try JSONDecoder().decode(WatchListMovie.self, from: jsonData)
                    print(postMovie.tmdb_id)
                    completion(.success(postMovie))
                } catch {
                    completion(.failure(error))
                }
        }
            dataTask.resume()
    }
  }
    
    func getAllMovie(completion: @escaping(Result<WatchListMovieData,Error>) -> Void) {
        
        let stringUrl = "http://127.0.0.1:1234/movies"
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
                
                guard let data = data else{
                    print("Empty Data")
                    return
                }
        }
            dataTask.resume()
            print("Deleted succesfully film with id = \(id)" )
    }
  }
    
    
    func fecthMovieById(id:Int) -> Void {
        self.getMovieById(id: id) { (results) in
                switch results {
                case .failure(let error):
                    print(error)

                case .success(let watchListMovie):
                 let test = watchListMovie.getTitle()
                print(test)
                }
            }
    }
}
    
    /*func getMovieInfos(movieTitle: String){
        let buildUrl = self.ApiUrl + self.ApiKey + "&query=\(name)"
        print(buildUrl)
        guard let request = URL(string: buildUrl ) else {
            fatalError("Error while building url")
        }
        
        
        let session = URLSession.shared
        let task = session.dataTask(with:request) { (data, response, error) in
            if let data = data {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    
                        }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dict = json as? [String: Any]{
                        if let id = dict["page"] as? String{
                            DispatchQueue.main.async {
                                let result = id
                                print(result)
                            }
                        }
                    }
                } catch {
                    print(error)
                }

            }
        }
        
        task.resume()
        
    }*/

    
    

