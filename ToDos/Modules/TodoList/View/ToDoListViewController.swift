//
//  ToDoListViewController.swift
//  ToDos
//
//  Created by Daniil on 03.02.2025.
//

import UIKit
import TinyConstraints

final class ToDoListViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let toolBar = UIToolbar()
    private var toolbarLabel: UILabel?
    
    private let operationQueue = OperationQueue()
    var presenter: ToDoListViewOutput?
            
    override func viewDidLoad() {
        setupViews()
        setupConstraints()
        presenter?.viewDidLoadHandler()
    }
    
}

extension ToDoListViewController: ToDoListViewInput {
    var navController: UINavigationController? {
        return self.navigationController
    }
    
    func reloadRow(at id: Int) {
        mainQueue { [weak self] in
            self?.tableView.reloadRows(at: [IndexPath(row: id, section: 0)], with: .none)
        }
    }
    
    func reloadTableView() {
        mainQueue { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func setupToolBarTitle(_ title: String) {
        mainQueue { [weak self] in
            self?.toolbarLabel?.text = title
            self?.toolbarLabel?.sizeToFit()
        }
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
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
              let _ = tableView.dequeueReusableCell(
                withIdentifier: Constants.tableViewReusableCell
              ) as? ToDoListTableViewCell else {
            return
        }
        presenter.didTapCell(cellId: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let actionProvider: UIContextMenuActionProvider = { _ in
            let editAction: UIMenuElement = UIAction(title: "Edit") { _ in
                self.presenter?.editTodo(cellId: indexPath.row)
            }
            
            let deleteAction: UIMenuElement = UIAction(title: "Delete") { [weak self] _ in
                self?.presenter?.deleteTodo(cellId: indexPath.row)
            }
            
            let menu = UIMenu(title: "", image: nil, identifier: nil, children: [editAction, deleteAction])
            return menu
        }
        
        return UIContextMenuConfiguration(actionProvider: actionProvider)
        
    }
    
}

//MARK: - UISearchResultsUpdating

extension ToDoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let presenter,
              let text = searchController.searchBar.text else { return }
        presenter.searchBy(text: text)
    }
    
}

//MARK: - Helpers

private extension ToDoListViewController {
    func setupViews() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithTransparentBackground()
        standardAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navController?.navigationBar.prefersLargeTitles = true
        navController?.navigationBar.standardAppearance = standardAppearance
        navigationItem.title = Constants.navigationBar
        
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
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let textLabel = UILabel()
        textLabel.textColor = .white
        toolbarLabel = textLabel
        let textButton = UIBarButtonItem(customView: textLabel)
        
        let addButton = UIBarButtonItem(
            image: UIImage(systemName: "square.and.pencil"),
            style: .plain,
            target: self,
            action: #selector(addButtonHandler)
        )
        addButton.tintColor = .yellow
        toolBar.barTintColor = .black
        toolBar.setItems([spaceButton, textButton, spaceButton, addButton], animated: false)
    }
    
    func setupConstraints() {
        view.addSubview(toolBar)
        toolBar.horizontalToSuperview()
        toolBar.bottomToSuperview(usingSafeArea: true)
        toolBar.height(49)
        
        view.addSubview(tableView)
        tableView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        tableView.bottomToTop(of: toolBar)
    }
    
    func mainQueue(_ task: @escaping () -> Void) {
        OperationQueue.main.addOperation(task)
    }
    
    @objc
    private func addButtonHandler() {
        presenter?.createTodo()
    }
}

fileprivate enum Constants {
    static let navigationBar = "ToDos"
    static let tableViewReusableCell = "\(ToDoListTableViewCell.self)"
}
