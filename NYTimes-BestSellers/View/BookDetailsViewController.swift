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
        
        view.addSubview(containerStackView)
        view.addSubview(bookCoverImageView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(authorLabel)
        containerStackView.addArrangedSubview(descriptionLabel)

        NSLayoutConstraint.activate([
        bookCoverImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        bookCoverImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        containerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        containerStackView.topAnchor.constraint(equalTo: bookCoverImageView.bottomAnchor, constant: 20),
        ])
        loadImage(bookImageURL)
        titleLabel.text = bookTitle
        authorLabel.text = bookAuthor
        descriptionLabel.text = bookDescription
    }
    
    // MARK: - Views
    var bookCoverImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    
    var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .vertical
        return stackView
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
    
    var bookImageURL: String {
        return bookDetails!.bookImage
    }
    
    func loadImage(_ urlString: String) {
        let url = URL(string: urlString)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.bookCoverImageView.image = UIImage(data: data!)
            }
        }
    }
}

// MARK: - Previews

#Preview {
    let mockBook = Book(
        author: "ONE and Yusuke Murata",
        bookImage: "https://storage.googleapis.com/du-prd/books/images/9781421590158.jpg",
        description: "Saitama sneaks into a combat tournament in order to hone his martial arts skills.",
        title: "ONE-PUNCH MAN, VOL. 10", 
        bookImageHeight: 495,
        bookImageWidth: 330
    )
    let vc = BookDetailsViewController()
    vc.bookDetails = mockBook
    return vc
}
