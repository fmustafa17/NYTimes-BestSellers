//
//  BookViewModel.swift
//  NYTimes-BestSellers
//
//  Created by Farhana Mustafa on 7/22/22.
//

import Combine
import Foundation

class BookViewModel: ObservableObject {
    
    // Combine

    @Published var booksResults: BookListResults?
    
    func fetchBookData() {
        let category = getRandomBookCategory()
        
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
                let bookListResults = try JSONDecoder().decode(BookListResults.self,
                                                             from: data)
                successHandler(bookListResults)
            } catch {
                errorHandler(error)
            }
        }
        task.resume()
    }
    
    // Async Await
    func fetchBooksWithAsyncAwait() async throws -> BookListResults {
        let category = getRandomBookCategory()
        let baseURL = "https://api.nytimes.com/svc/books/v3/lists/current/"
        let apiKey = Config.apiKey.rawValue
        let fullURLString = baseURL + category + ".json?api-key=" + apiKey
        
        guard let url = URL(string: fullURLString) else {
            print("Couldn't retrieve a URL with \(fullURLString)")
            throw NYTimesError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let bookListResults = try JSONDecoder().decode(BookListResults.self,
                                                     from: data)
        return bookListResults
    }
    
    func getRandomBookCategory() -> String {
        return BookCategory.allCases.randomElement()?.rawValue ?? "manga"
    }
 
    enum NYTimesError: Error {
        case invalidURL
    }
}
