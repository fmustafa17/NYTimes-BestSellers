//
//  BookCollectionViewCell.swift
//  NYTimes-BestSellers
//
//  Created by Farhana Mustafa on 7/23/22.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifer = "BookCollectionViewCell"
    
    let bookCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addImageView() {
        self.contentView.addSubview(bookCoverImageView)
        bookCoverImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        bookCoverImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        bookCoverImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        bookCoverImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    
}
