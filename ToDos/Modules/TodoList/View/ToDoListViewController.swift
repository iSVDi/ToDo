//
//  ToDoListViewController.swift
//  ToDos
//
//  Created by Daniil on 03.02.2025.
//

import UIKit
import TinyConstraints

class ToDoListViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let mockToDos: [ToDo] = [
        .init(
            id: 1,
            title: "Do something nice",
            description: "description cool and really, really really ",
            isCompleted: false,
            creationDate: .now
        ),
        .init(
            id: 2,
            title: "Memorize a poem",
            description: "description cool and really, really really really really really really really really really really really really really really really really really really really really really  long",
            isCompleted: true,
            creationDate: .now
        ),
        .init(
            id: 3,
            title: "Watch a classic movie",
            description: "description cool and really, really really really really really really really really really really really really really really really really really really really really really  long",
            isCompleted: true,
            creationDate: .now
        )
    ]
    
    override func viewDidLoad() {
        setupViews()
        setupConstraints()
    }
    
}

//MARK: UITableViewDelegate, UITableViewDataSource

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mockToDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewReusableCell),
              let toDoCell = cell as? ToDoListTableViewCell else { return UITableViewCell() }
        toDoCell.setupData(model: mockToDos[indexPath.row])
        return toDoCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewReusableCell),
              let toDoCell = cell as? ToDoListTableViewCell else { return }
        //MARK: implement
        print("did tap on todo cell")
    }
    
}

private extension ToDoListViewController {
    func setupViews() {
        navigationItem.title = Constants.navigationBar
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 106
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ToDoListTableViewCell.self, forCellReuseIdentifier: Constants.tableViewReusableCell)
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
