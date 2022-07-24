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
    @Published var booksResults: BookListResults? = nil
    
    init() {
        self.apiManager = APIManager()
    }
    
    func fetchBookData() {
        let category = "graphic-books-and-manga"
        
        apiManager?.fetchBookListResults(with: category,
        successHandler: { [weak self] (books) in
            self?.booksResults = books
        }, errorHandler: { (error) in
            print(error)
        })
    }
}
