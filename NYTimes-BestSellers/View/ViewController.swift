//
//  ViewController.swift
//  NYTimes-BestSellers
//
//  Created by Farhana Mustafa on 7/22/22.
//

import Combine
import UIKit

class ViewController: UITableViewController {
    var bookViewModel: BookViewModel!
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookViewModel = BookViewModel()
        setUpTableView()
        
        bindViewModel()
    }
    
    private func setUpTableView() {
        self.tableView.register(BookListTableViewCell.self,
                                forCellReuseIdentifier: BookListTableViewCell.reuseIdentifer)
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 200.0
        
        tableView.rowHeight = 100.0
    }
    
    /// Fetch the data and publish the event
    private func bindViewModel() {
        self.bookViewModel.fetchBookData()
        
        bookViewModel.$booksResults
            .receive(on: DispatchQueue.main)
            .sink { [weak self] booksResults in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    
}

// MARK: - UITableViewDataSource
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.bookViewModel.booksResults.count
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookListTableViewCell.reuseIdentifer, for: indexPath) as? BookListTableViewCell else {
            print("Couldn't dequeue BookListTableViewCell")
            return UITableViewCell()
        }
        cell.updateUI(with: self.bookViewModel.booksResults, on: indexPath.row)
        
//        cell.bookResultsData = self.bookViewModel.booksResults // pass the data to the tableViewCell in order to show the info in the collectionView
//        cell.categoryTitleLabel.text = self.bookViewModel.booksResults[indexPath.row].title
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController {
    
}
