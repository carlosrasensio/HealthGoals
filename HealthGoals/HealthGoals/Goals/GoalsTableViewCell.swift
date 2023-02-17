//
//  GoalsTableViewCell.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import UIKit

protocol GoalsTableViewCellProtocol: AnyObject {
  static var identifier: String { get }
  func setupUI()
  func setupInfo(with model: Goal)
}

final class GoalsTableViewCell: UITableViewCell {
  // MARK: Objects
  private lazy var titleLabel = UILabel()
  private lazy var descriptionLabel = UILabel()
  
  // MARK: Initializers
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Cell configuration
  override func prepareForReuse() {
    titleLabel.text = nil
    descriptionLabel.text = nil
  }
}

// MARK: - GoalsTableViewCellProtocol

extension GoalsTableViewCell: GoalsTableViewCellProtocol {
  static var identifier: String { String(describing: self) }
  
  func setupUI() {
    setupTitleLabel()
    setupDescriptionLabel()
  }
  
  func setupInfo(with model: Goal) {
    titleLabel.text = model.title
    descriptionLabel.text = model.description
  }
}

// MARK: - Private methods

private extension GoalsTableViewCell {
  func setupTitleLabel() {
    titleLabel.backgroundColor = .systemCyan
    titleLabel.textColor = .white
    titleLabel.layer.cornerRadius = 5
    titleLabel.layer.masksToBounds = true
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
      titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 12),
      titleLabel.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
  
  func setupDescriptionLabel() {
    descriptionLabel.backgroundColor = .systemCyan
    descriptionLabel.textColor = .white
    descriptionLabel.numberOfLines = 0
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(descriptionLabel)
    NSLayoutConstraint.activate([
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
      descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
      descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 12),
      descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 12)
    ])
  }
}
