//
//  ToDoListViewControllerImpl.swift
//  ToDos
//
//  Created by Daniil on 03.02.2025.
//

import UIKit
import TinyConstraints

protocol ToDoListPresenterToView: AnyObject {
    func reloadRow(at id: Int)
    func reloadTableView()
}

class ToDoListViewControllerImpl: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    var presenter: ToDoListViewToPresenter?

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupViews()
        setupConstraints()
        presenter?.viewDidLoadHandler()
    }
    
}

extension ToDoListViewControllerImpl: ToDoListPresenterToView {
    func reloadRow(at id: Int) {
        tableView.reloadRows(at: [IndexPath(row: id, section: 0)], with: .none)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource

extension ToDoListViewControllerImpl: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getAllTodos().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let todos = presenter?.getAllTodos(),
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewReusableCell),
              let todoCell = cell as? ToDoListTableViewCell else { return UITableViewCell() }
        todoCell.setupData(model: todos[indexPath.row])
        return todoCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter,
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewReusableCell),
              let todoCell = cell as? ToDoListTableViewCell else { return }
        presenter.didTapCell(id: indexPath.row)
    }
    
}

//MARK: - UISearchResultsUpdating

extension ToDoListViewControllerImpl: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let presenter,
            let text = searchController.searchBar.text else { return }
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
