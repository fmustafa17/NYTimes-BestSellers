//
//  BookDetailsViewController.swift
//  NYTimes-BestSellers
//
//  Created by Farhana Mustafa on 10/9/23.
//

import UIKit

class BookDetailsViewController: UIViewController {
    var bookDetails: Book!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        titleLabel.text = bookTitle
        /*
         Optional(NYTimes_BestSellers.Book(author: "ONE and Yusuke Murata", bookImage: "https://storage.googleapis.com/du-prd/books/images/9781421590158.jpg", description: "Saitama sneaks into a combat tournament in order to hone his martial arts skills.", title: "ONE-PUNCH MAN, VOL. 10", bookImageHeight: 495, bookImageWidth: 330))
         */
    }
    
    // MARK: - Views
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    // MARK: - ViewModel
    var bookTitle: String {
        return bookDetails!.title
    }
    
    var bookAuthor: String {
        return bookDetails!.author
    }
    
    var bookDescription: String {
        return bookDetails!.description
    }

}

// MARK: - Previews

#Preview {
    let mockBook = Book(
        author: "Farhana",
        bookImage: "",
        description: "description",
        title: "Farhana's Book",
        bookImageHeight: 100,
        bookImageWidth: 100
    )
    let vc = BookDetailsViewController()
    vc.bookDetails = mockBook
    return vc
}
