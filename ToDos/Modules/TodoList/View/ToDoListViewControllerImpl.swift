//
//  ToDoListViewControllerImpl.swift
//  ToDos
//
//  Created by Daniil on 03.02.2025.
//

import UIKit
import TinyConstraints

protocol ToDoListViewController {
    func reloadTableView()
}

class ToDoListViewControllerImpl: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let presenter: ToDoListPresenter = ToDoListPresenterImpl()
    
    override func viewDidLoad() {
        setupViews()
        setupConstraints()
    }
    
}

//MARK: UITableViewDelegate, UITableViewDataSource

extension ToDoListViewControllerImpl: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getAllToDos().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewReusableCell),
              let toDoCell = cell as? ToDoListTableViewCell else { return UITableViewCell() }
        toDoCell.setupData(model: presenter.getAllToDos()[indexPath.row])
        return toDoCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewReusableCell),
              let toDoCell = cell as? ToDoListTableViewCell else { return }
        //MARK: implement
        presenter.didTapCell(id: indexPath.row)
    }
    
}

//MARK: - UISearchResultsUpdating

extension ToDoListViewControllerImpl: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        //MARK: implement
        presenter.searchBy(text: text)
    }
    
}

private extension ToDoListViewControllerImpl {
    func setupViews() {
        navigationItem.title = Constants.navigationBar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 106
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ToDoListTableViewCell.self, forCellReuseIdentifier: Constants.tableViewReusableCell)
        tableView.backgroundColor = .black
        tableView.separatorColor = .systemGray3
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search"
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    func setupConstraints() {
        view.addSubview(tableView)
        tableView.edgesToSuperview()
    }
}

fileprivate enum Constants {
    static let navigationBar = "Задачи"
    static let tableViewReusableCell = "\(ToDoListTableViewCell.self)"
}
