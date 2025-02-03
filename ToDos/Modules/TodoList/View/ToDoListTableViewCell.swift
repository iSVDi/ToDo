//
//  ToDoListTableViewCell.swift
//  ToDos
//
//  Created by Daniil on 03.02.2025.
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {
    private let stateImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(model: ToDo) {
        let imageName = model.isCompleted ? Constants.completedImageName : Constants.uncompletedImageName
        stateImageView.image = UIImage(systemName: imageName)
        stateImageView.tintColor = model.isCompleted ? .yellow : .gray
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        dateLabel.text = getDateLabelFrom(model.creationDate)
    }
    
}

private extension ToDoListTableViewCell {
    func setupViews() {
        stateImageView.size(Constants.stateImageSize)
        stateImageView.contentMode = .scaleAspectFit
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        descriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        descriptionLabel.numberOfLines = 2
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    func setupLayout() {
        let mainView = UIView()
        self.contentView.addSubview(mainView)
        mainView.edgesToSuperview()
        
        let vStack = UIView()
        vStack.stack([titleLabel, descriptionLabel, dateLabel], axis: .vertical, spacing: 6)
        [stateImageView, vStack].forEach { view in
            mainView.addSubview(view)
        }
        
        stateImageView.topToSuperview(offset: 11)
        stateImageView.leftToSuperview(offset: 20)
        
        vStack.leftToRight(of: stateImageView, offset: 8)
        vStack.verticalToSuperview(insets: .vertical(12))
        vStack.rightToSuperview()
    }
    
    func getDateLabelFrom(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "DD/MM/YYYY"
        return dateFormatter.string(from: date)
    }
}

fileprivate enum Constants {
    static let completedImageName = "checkmark.circle"
    static let uncompletedImageName = "circle"
    static let stateImageSize = CGSize(width: 24, height: 24)
}
