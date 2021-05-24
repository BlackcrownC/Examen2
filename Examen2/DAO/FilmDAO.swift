//
//  FilmDAO.swift
//  Examen2
//
//  Created by Mac11 on 2021-05-24.
//

import Foundation

public class FilmDAO {
    internal init() {
    }
    static let shared = FilmDAO()
    
    func getGenres() -> [Genre] {
        var genres: [Genre] = []
        let sema = DispatchSemaphore(value: 0)
        
        let headers = [
          "content-type": "application/json",
          "cache-control": "no-cache"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://script.google.com/macros/s/AKfycbx8f6K3JD_zf3hCixfHB01EbWt-oo84dV6e7_IZ8baSMSR00gkDZbwDUtGE5jSBwbcH/exec?action=genres")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error!)
          } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse!)
          }
            if let data = data{
              do{
                  let json = try JSONSerialization.jsonObject(with: data, options: [])
                  if let result = json as? [[String: Any]]{
                    for item in result{
                        genres.append(Genre(id: item["id"] as! Int, name: item["name"] as! String))
                    }
                    sema.signal()
                  }
                  
              }catch{
                print(error)
              }
            }
        })

        dataTask.resume()
        sema.wait()
        return genres
    }
    
    
    public func getFilms(genreId: Int) -> [Film] {
        var films: [Film] = []
        let sema = DispatchSemaphore(value: 0)
        
        let headers = [
          "content-type": "application/json",
          "cache-control": "no-cache"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://script.google.com/macros/s/AKfycbx8f6K3JD_zf3hCixfHB01EbWt-oo84dV6e7_IZ8baSMSR00gkDZbwDUtGE5jSBwbcH/exec?action=films&genreId=" + genreId.description)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error!)
          } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse!)
          }
            if let data = data{
              do{
                  let json = try JSONSerialization.jsonObject(with: data, options: [])
                  if let result = json as? [[String: Any]]{
                    for item in result{
                        if item["posterURL"] != nil {
                            films.append(Film(id: item["id"] as! Int, title: item["title"] as! String, releaseDate: item["releaseDate"] as! String, genreId: item["genreId"] as! Int, posterURL: item["posterURL"] as! String, numberOfReviews: item["numberOfReviews"] as! Int, likes: item["likes"] as! Int))
                        } else {
                            films.append(Film(id: item["id"] as! Int, title: item["title"] as! String, releaseDate: item["releaseDate"] as! String, genreId: item["genreId"] as! Int, numberOfReviews: item["numberOfReviews"] as! Int, likes: item["likes"] as! Int))
                        }
                    }
                    sema.signal()
                  }
                  
              }catch{
                print(error)
              }
            }
        })

        dataTask.resume()
        sema.wait()
        return films
    }
    
    func sendlike(filmId: Int, isLiked: Bool) -> String {
        var message = "Post didn't work"
        
        let sema = DispatchSemaphore(value: 0)
        var like = 0
        if isLiked {
            like = 1
        }
        
        let headers = [
          "content-type": "application/json",
          "cache-control": "no-cache"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://script.google.com/macros/s/AKfycbx8f6K3JD_zf3hCixfHB01EbWt-oo84dV6e7_IZ8baSMSR00gkDZbwDUtGE5jSBwbcH/exec?filmId=" + filmId.description + "&like=" + like.description)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error!)
          } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse!)
            if (httpResponse?.statusCode == 200) {
                message = "Posted : " + like.description + " likes review to filmId : " + filmId.description
            }
          }
            sema.signal()
        })

        dataTask.resume()
        sema.wait()
        
        return message
    }
}
