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
  private lazy var containerView = UIView()
  private lazy var titleLabel = UILabel()
  
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
  }
}

// MARK: - GoalsTableViewCellProtocol

extension GoalsTableViewCell: GoalsTableViewCellProtocol {
  static var identifier: String { String(describing: self) }
  
  func setupUI() {
    setupContainerView()
    setupTitleLabel()
  }
  
  func setupInfo(with model: Goal) {
    titleLabel.text = model.title
  }
}

// MARK: - Private methods

private extension GoalsTableViewCell {
  func setupContainerView() {
    containerView.backgroundColor = .systemCyan
    containerView.layer.cornerRadius = 6
    containerView.layer.shadowOffset = .zero
    containerView.layer.shadowRadius = 10
    containerView.layer.shadowOpacity = 0.5
    containerView.layer.shadowColor = UIColor.cyan.cgColor
    containerView.layer.shouldRasterize = true
    containerView.layer.rasterizationScale = UIScreen.main.scale
    containerView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(containerView)
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
    ])
  }
  
  func setupTitleLabel() {
    titleLabel.textColor = .white
    titleLabel.font = .boldSystemFont(ofSize: 30)
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.textAlignment = .center
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
      titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
      titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
    ])
  }
}
