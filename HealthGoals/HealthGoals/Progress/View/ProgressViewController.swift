//
//  ProgressViewController.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import UIKit
import HealthKitUI

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
    setupHealthKitUI()
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
    titleLabel.textColor = .systemCyan
    titleLabel.layer.cornerRadius = 5
    titleLabel.layer.masksToBounds = true
    titleLabel.font = .boldSystemFont(ofSize: 30)
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.textAlignment = .center
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
    ])
  }
  
  func setupDescriptionLabel() {
    descriptionLabel.textColor = .systemCyan
    descriptionLabel.layer.cornerRadius = 5
    descriptionLabel.layer.masksToBounds = true
    descriptionLabel.font = .systemFont(ofSize: 18)
    descriptionLabel.textAlignment = .center
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
    goalLabel.textColor = .systemCyan
    goalLabel.layer.cornerRadius = 5
    goalLabel.layer.masksToBounds = true
    goalLabel.font = .boldSystemFont(ofSize: 14)
    goalLabel.textAlignment = .center
    goalLabel.adjustsFontSizeToFitWidth = true
    goalLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(goalLabel)
    NSLayoutConstraint.activate([
      goalLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
      goalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      goalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
    ])
  }
  
  func setupTypeLabel() {
    typeLabel.textColor = .systemCyan
    typeLabel.layer.cornerRadius = 5
    typeLabel.layer.masksToBounds = true
    typeLabel.font = .boldSystemFont(ofSize: 14)
    typeLabel.textAlignment = .center
    typeLabel.adjustsFontSizeToFitWidth = true
    typeLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(typeLabel)
    NSLayoutConstraint.activate([
      typeLabel.topAnchor.constraint(equalTo: goalLabel.bottomAnchor, constant: 12),
      typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      typeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
    ])
  }
  
  func setupTrophyLabel() {
    trophyLabel.textColor = .systemCyan
    trophyLabel.layer.cornerRadius = 5
    trophyLabel.layer.masksToBounds = true
    trophyLabel.font = .boldSystemFont(ofSize: 14)
    trophyLabel.textAlignment = .center
    trophyLabel.adjustsFontSizeToFitWidth = true
    trophyLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(trophyLabel)
    NSLayoutConstraint.activate([
      trophyLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 24),
      trophyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      trophyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
    ])
  }
  
  func setupPointsLabel() {
    pointsLabel.textColor = .systemCyan
    pointsLabel.layer.cornerRadius = 5
    pointsLabel.layer.masksToBounds = true
    pointsLabel.font = .boldSystemFont(ofSize: 14)
    pointsLabel.textAlignment = .center
    pointsLabel.adjustsFontSizeToFitWidth = true
    pointsLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(pointsLabel)
    NSLayoutConstraint.activate([
      pointsLabel.topAnchor.constraint(equalTo: trophyLabel.bottomAnchor, constant: 12),
      pointsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      pointsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
    ])
  }
  
  func setupHealthKitUI() {
    
  }
  
  func showActivityIndicator(_ show: Bool = true) {
    activityIndicator.isHidden = !show
    show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
  }
}
