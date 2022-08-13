//
//  BookListResults.swift
//  NYTimes-BestSellers
//
//  Created by Farhana Mustafa on 7/22/22.
//

import Foundation

struct BookListResults: Decodable {
    let numResults: Int
    let results: Results

    enum CodingKeys: String, CodingKey {
        case numResults = "num_results"
        case results
    }
}

struct Results: Decodable {
    let books: [Book]
    let listName: String
    let listNameEncoded: String
    
    enum CodingKeys: String, CodingKey {
        case books
        case listName = "list_name"
        case listNameEncoded = "list_name_encoded"
    }
}

struct Book: Decodable {
    let author: String
    let bookImage: String
    let description: String
    let title: String
    let bookImageHeight: Int
    let bookImageWidth: Int
           
    enum CodingKeys: String, CodingKey {
        case author
        case description
        case title

        case bookImage = "book_image"
        case bookImageHeight = "book_image_height"
        case bookImageWidth = "book_image_width"
    }
}
