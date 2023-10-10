//
//  ViewController.swift
//  NYTimes-BestSellers
//
//  Created by Farhana Mustafa on 7/22/22.
//

import Combine
import UIKit

class ViewController: UITableViewController {
    
    // MARK: - Dependencies
    var bookViewModel: BookViewModel!
    var books: BookListResults!
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bookViewModel = BookViewModel()
        setUpTableView()
        
        // Combine
        // bindViewModel()
        
        // Async Await
        Task {
            await getBookData()
        }
    }

    // MARK: - Functionality

    // Combine
    private func bindViewModel() {
        self.bookViewModel.fetchBookData()
        
        bookViewModel.$booksResults
            .receive(on: DispatchQueue.main)
            .sink { [weak self] booksResults in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    // Async Await
    private func getBookData() async {
        do {
            books = try await bookViewModel.fetchBooksWithAsyncAwait()
            tableView.reloadData()
        } catch {
            print("Request failed:", error)
        }
    }
    
    private func setUpTableView() {
        tableView.register(BookListTableViewCell.self,
                           forCellReuseIdentifier: BookListTableViewCell.reuseIdentifer)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 250.0
    }
}

// MARK: - UITableViewDataSource
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookListTableViewCell.reuseIdentifer, for: indexPath) as? BookListTableViewCell else {
            print("Couldn't dequeue BookListTableViewCell")
            return UITableViewCell()
        }
        
        if let bookData = books {
            cell.bookListViewController = self
            cell.updateUI(with: bookData, on: indexPath.row)
        }
        
        return cell
    }
}
