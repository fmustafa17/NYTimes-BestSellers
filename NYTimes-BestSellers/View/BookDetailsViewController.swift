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
        
        addScrollView()
        addContentView()
        contentView.addSubview(bookCoverImageView)
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(authorLabel)
        containerStackView.addArrangedSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            bookCoverImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bookCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerStackView.topAnchor.constraint(equalTo: bookCoverImageView.bottomAnchor, constant: 20),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
        loadImage(bookImageURL)
        titleLabel.text = bookTitle
        authorLabel.text = bookAuthor
        descriptionLabel.text = bookDescription
    }
    
    // MARK: - Views
    
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    func addScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        scrollView.contentInset.bottom = view.safeAreaInsets.bottom
    }
    
    func addContentView() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        let heightConstraints = contentView.heightAnchor.constraint(equalTo: safeArea.heightAnchor)
        heightConstraints.priority = UILayoutPriority(250)
        heightConstraints.isActive = true
    }
    
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
