//
//  ToDoDetailsViewController.swift
//  ToDos
//
//  Created by Daniil on 07.02.2025.
//

import Foundation
import UIKit

class ToDoDetailsViewController: UIViewController {
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }
}

private extension ToDoDetailsViewController {
    
    func setupViews() {
        navigationController?.navigationBar.tintColor = .yellow
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.backgroundColor = .black
        titleLabel.text = "Untitled"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 34, weight: .bold)
        
        dateLabel.text = "02/03/2025"
        dateLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 12)
        textView.text = "really long description really long description really long description really long description really long description  really long description really long description really long description really long description really long description really long description really long description really long description really long description really long description really long description really long description really long description really long description really long description"
        textView.textColor = .white
        textView.backgroundColor = .clear
        ///This ensures the UITextView resizes itself based on its content.
        textView.isScrollEnabled = false
        textView.font = .systemFont(ofSize: 16)
    }
    
    func setupLayout() {
        [titleLabel, dateLabel, textView].forEach {
            view.addSubview($0)
            $0.horizontalToSuperview(insets: .horizontal(16))
        }
        
        titleLabel.topToSuperview(offset: 16, usingSafeArea: true)
        dateLabel.topToBottom(of: titleLabel, offset: 8)
        textView.topToBottom(of: dateLabel, offset: 16)
    }
}
