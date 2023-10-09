//
//  BookListTableViewCell.swift
//  NYTimes-BestSellers
//
//  Created by Farhana Mustafa on 7/22/22.
//

import UIKit

class BookListTableViewCell: UITableViewCell {
    static let reuseIdentifer = "BookListTableViewCell"
    
    var bookResultsData: BookListResults?
    
    // Collection view flow layout
    var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10,
                                           left: 10,
                                           bottom: 10,
                                           right: 10)
        return layout
    }()
    
    var collectionView: UICollectionView!
    
    lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCategoryTitleLabel()
        setUpCollectionView()
    }
    
    func setUpCategoryTitleLabel() {
        self.contentView.addSubview(categoryTitleLabel)
        categoryTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        categoryTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        categoryTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
    
    func setUpCollectionView() {
        collectionView = UICollectionView(frame: self.contentView.frame,
                                          collectionViewLayout: collectionViewFlowLayout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(BookCollectionViewCell.self,
                                forCellWithReuseIdentifier: BookCollectionViewCell.reuseIdentifer)
        
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        self.contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    func updateUI(with bookResults: BookListResults, on index: Int) {
        self.bookResultsData = bookResults
        self.categoryTitleLabel.text = bookResultsData?.results.listName
        self.collectionView.reloadData()
    }
    
    func assignImage(to collectionViewCell: BookCollectionViewCell, on index: Int) {
        let urlString = bookResultsData?.results.books[index].bookImage ?? ""
        
        let url = URL(string: urlString)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                collectionViewCell.bookCoverImageView.image = UIImage(data: data!)
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource
extension BookListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookResultsData?.results.books.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.reuseIdentifer, for: indexPath) as? BookCollectionViewCell else {
            print("Couldn't dequeue BookCollectionViewCell")
            return UICollectionViewCell()
        }
        
        assignImage(to: collectionViewCell, on: indexPath.row)
        
        return collectionViewCell
    }
    
}

// MARK: - UICollectionViewDelegate
extension BookListTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BookListTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 200)
    }
}
