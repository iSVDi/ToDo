//
//  ToDoDetailsViewController.swift
//  ToDos
//
//  Created by Daniil on 07.02.2025.
//

import Foundation
import UIKit

class ToDoDetailsViewController: UIViewController {
    
    private let titleField = UITextField()
    private let dateLabel = UILabel()
    private let datePicker = UIDatePicker()
    private let textView = UITextView()
    
    var presenter: ToDoDetailsViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        presenter?.viewDidLoadHandler()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let title = titleField.text, let description = textView.text else { return }
        let todoDetailsModel = ToDoDetails(title: title, description: description)
        presenter?.saveTodo(todoDetails: todoDetailsModel)
    }
    
}

extension ToDoDetailsViewController: ToDoDetailsViewInput {
    
    func setupData(todo: ToDo) {
        OperationQueue.main.addOperation { [weak self] in
            guard let self else { return }
            titleField.text = todo.title
            dateLabel.text = todo.creationDate.getFormattedDate()
            textView.text = todo.description
        }
    }
    
    func disableUserInteraction() {
        titleField.isUserInteractionEnabled = false
        textView.isUserInteractionEnabled = false
    }
    
}

private extension ToDoDetailsViewController {
    
    func setupViews() {
        navigationController?.navigationBar.tintColor = .yellow
        self.navigationItem.largeTitleDisplayMode = .never
        
        view.backgroundColor = .black
        titleField.textColor = .white
        titleField.font = .systemFont(ofSize: 34, weight: .bold)

        dateLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 12)
        
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 16)
        ///This ensures the UITextView resizes itself based on its content.
        textView.isScrollEnabled = false
    }
    
    func setupLayout() {
        [titleField, dateLabel, textView].forEach {
            view.addSubview($0)
            $0.horizontalToSuperview(insets: .horizontal(16))
        }
        
        titleField.topToSuperview(offset: 8, usingSafeArea: true)
        dateLabel.topToBottom(of: titleField, offset: 8)
        textView.topToBottom(of: dateLabel, offset: 16)
    }
    
}
