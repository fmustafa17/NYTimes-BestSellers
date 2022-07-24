//
//  BookListTableViewCell.swift
//  NYTimes-BestSellers
//
//  Created by Farhana Mustafa on 7/22/22.
//

import UIKit

class BookListTableViewCell: UITableViewCell {
    static let reuseIdentifer = "BookListTableViewCell"

    var bookResultsData: [Book]?
    
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
        return label
    }()
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpCollectionView()
        
//        categoryTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
//        categoryTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
//        categoryTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        //        categoryTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
//        collectionView.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func setUpCollectionView() {
        collectionView = UICollectionView(frame: self.bounds,
                                          collectionViewLayout: collectionViewFlowLayout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(BookCollectionViewCell.self,
                                forCellWithReuseIdentifier: BookCollectionViewCell.reuseIdentifer)
        
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.backgroundColor = .blue
        
        self.addSubview(collectionView)
        contentView.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateUI(with bookResults: [Book], on index: Int) {
        self.bookResultsData = bookResults
//        self.categoryTitleLabel.text = bookResults[index].title
        collectionView.reloadData()
    }
    
    func assignImage(to collectionViewCell: BookCollectionViewCell, on index: Int) {
        let urlString = bookResultsData?[index].bookImage ?? ""
        
        let url = URL(string: urlString)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                collectionViewCell.bookCoverImageView.image = UIImage(data: data!)
            }
        }
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
        return bookResultsData?.count ?? 0
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
        print(indexPath.row)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BookListTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
