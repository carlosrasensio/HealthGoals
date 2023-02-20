//
//  ProgressViewController.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import UIKit

protocol ProgressViewControllerProtocol {
  func setupUI()
  func setupInfo()
}

final class ProgressViewController: UIViewController {
  // MARK: Objects
  private lazy var activityIndicator = UIActivityIndicatorView()
  private lazy var titleLabel = UILabel()
  private lazy var descriptionLabel = UILabel()
  private lazy var goalLabel = UILabel()
  private lazy var typeLabel = UILabel()
  private lazy var trophyLabel = UILabel()
  private lazy var pointsLabel = UILabel()
  
  // MARK: Variables
  private let presenter: ProgressPresenterProtocol
    
  // MARK: Initializers
  init(presenter: ProgressPresenterProtocol) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupInfo()
  }
}

// MARK: - ProgressViewControllerProtocol

extension ProgressViewController: ProgressViewControllerProtocol {
  func setupUI() {
    view.backgroundColor = .white
    setupActivityIndicator()
    setupTitleLabel()
    setupDescriptionLabel()
    setupGoalLabel()
    setupTypeLabel()
    setupTrophyLabel()
    setupPointsLabel()
  }
  
  func setupInfo() {
    navigationItem.title = presenter.navigationItemTitle
    titleLabel.text = presenter.title
    descriptionLabel.text = presenter.description
    goalLabel.text = presenter.goal
    typeLabel.text = presenter.type
    trophyLabel.text = presenter.trophy
    pointsLabel.text = presenter.points
  }
}

// MARK: - Private methods

private extension ProgressViewController {
  func setupActivityIndicator() {
    activityIndicator.color = .systemCyan
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(activityIndicator)
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      activityIndicator.heightAnchor.constraint(equalToConstant: 80),
      activityIndicator.widthAnchor.constraint(equalToConstant: 80)
    ])
  }
  
  func setupTitleLabel() {
    titleLabel.backgroundColor = .systemCyan
    titleLabel.textColor = .white
    titleLabel.layer.cornerRadius = 5
    titleLabel.layer.masksToBounds = true
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
    ])
  }
  
  func setupDescriptionLabel() {
    descriptionLabel.backgroundColor = .systemCyan
    descriptionLabel.textColor = .white
    descriptionLabel.layer.cornerRadius = 5
    descriptionLabel.layer.masksToBounds = true
    descriptionLabel.numberOfLines = 0
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(descriptionLabel)
    NSLayoutConstraint.activate([
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
      descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
    ])
  }
  
  func setupGoalLabel() {
    goalLabel.backgroundColor = .systemCyan
    goalLabel.textColor = .white
    goalLabel.layer.cornerRadius = 5
    goalLabel.layer.masksToBounds = true
    goalLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(goalLabel)
    NSLayoutConstraint.activate([
      goalLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
      goalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      goalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
    ])
  }
  
  func setupTypeLabel() {
    typeLabel.backgroundColor = .systemCyan
    typeLabel.textColor = .white
    typeLabel.layer.cornerRadius = 5
    typeLabel.layer.masksToBounds = true
    typeLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(typeLabel)
    NSLayoutConstraint.activate([
      typeLabel.topAnchor.constraint(equalTo: goalLabel.bottomAnchor, constant: 12),
      typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      typeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
    ])
  }
  
  func setupTrophyLabel() {
    trophyLabel.backgroundColor = .systemCyan
    trophyLabel.textColor = .white
    trophyLabel.layer.cornerRadius = 5
    trophyLabel.layer.masksToBounds = true
    trophyLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(trophyLabel)
    NSLayoutConstraint.activate([
      trophyLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 12),
      trophyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      trophyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
    ])
  }
  
  func setupPointsLabel() {
    pointsLabel.backgroundColor = .systemCyan
    pointsLabel.textColor = .white
    pointsLabel.layer.cornerRadius = 5
    pointsLabel.layer.masksToBounds = true
    pointsLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(pointsLabel)
    NSLayoutConstraint.activate([
      pointsLabel.topAnchor.constraint(equalTo: trophyLabel.bottomAnchor, constant: 12),
      pointsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      pointsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
    ])
  }
  
  func showActivityIndicator(_ show: Bool = true) {
    activityIndicator.isHidden = !show
    show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
  }
}
