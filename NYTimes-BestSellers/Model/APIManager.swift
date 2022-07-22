//
//  APIManager.swift
//  NYTimes-BestSellers
//
//  Created by Farhana Mustafa on 7/22/22.
//

import Combine
import Foundation

struct APIManager {
    static let jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    func fetchBookListResults(with category: String,
                              successHandler: @escaping (BookListResults) -> Void,
                              errorHandler: @escaping (Error) -> Void) {
        let baseURL = "https://api.nytimes.com/svc/books/v3/lists/current/"
        let category = "graphic-books-and-manga"
        let apiKey = "oF2w2Ev2hyPiaiJ4G2cEdBQ0btQFMIxT"
        let fullURLString = baseURL + category + ".json?api-key=" + apiKey
        
        guard let url = URL(string: fullURLString) else {
            print("Couldn't retrieve a URL from \(fullURLString)")
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error encounted:", error?.localizedDescription ?? "")
                return
            }
            
            guard let data = data else {
                print("Something went wrong with data")
                return
            }
            
            do {
                let bookListResults = try APIManager.jsonDecoder.decode(BookListResults.self,
                                                                        from: data)
                successHandler(bookListResults)
            } catch {
                print("Response:", response!)
                print(error)
            }
        }
        task.resume()
    }
}