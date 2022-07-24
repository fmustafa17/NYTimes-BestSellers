//
//  BookListTableViewCell.swift
//  NYTimes-BestSellers
//
//  Created by Farhana Mustafa on 7/22/22.
//

import UIKit

class BookListTableViewCell: UITableViewCell {
    static let reuseIdentifer = "BookListTableViewCell"

    lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
    }
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(categoryTitleLabel)

        self.selectionStyle = .none

        categoryTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        categoryTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        categoryTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        categoryTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
