//
//  BookViewModel.swift
//  NYTimes-BestSellers
//
//  Created by Farhana Mustafa on 7/22/22.
//

import Combine
import Foundation

class BookViewModel: ObservableObject {
    @Published var booksResults: BookListResults?
    
    func fetchBookData() {
        let category = BookCategory.allCases.randomElement()?.rawValue ?? "manga"
        
        self.fetchBookListResults(with: category,
                                  successHandler: { [weak self] (books) in
            self?.booksResults = books
        }, errorHandler: { (error) in
            print(error)
        })
    }
    
    private func fetchBookListResults(with category: String,
                                      successHandler: @escaping (BookListResults) -> Void,
                                      errorHandler: @escaping (Error) -> Void) {
        let baseURL = "https://api.nytimes.com/svc/books/v3/lists/current/"
        let apiKey = Config.apiKey.rawValue
        let fullURLString = baseURL + category + ".json?api-key=" + apiKey
        
        guard let url = URL(string: fullURLString) else {
            print("Couldn't retrieve a URL with \(fullURLString)")
            return
        }
        
        let request = URLRequest(url: url)
        
        let jsonDecoder = JSONDecoder()
        
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
                let bookListResults = try jsonDecoder.decode(BookListResults.self,
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
