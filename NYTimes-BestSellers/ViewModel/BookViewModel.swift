//
//  BookViewModel.swift
//  NYTimes-BestSellers
//
//  Created by Farhana Mustafa on 7/22/22.
//

import Combine
import Foundation

class BookViewModel: ObservableObject {
    private var apiManager: APIManager!
//    @Published var books: BookListResults!
    @Published var booksResults: [Book] = []
    
    init() {
        self.apiManager = APIManager()
    }
    
    func fetchBookData() {
        let category = "graphic-books-and-manga"
        
        apiManager?.fetchBookListResults(with: category,
        successHandler: { [weak self] (books) in
            self?.booksResults = books.results.books
        }, errorHandler: { (error) in
            print(error)
        })
    }
}
