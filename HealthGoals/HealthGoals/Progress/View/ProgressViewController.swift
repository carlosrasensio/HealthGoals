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
  func setupHealthKitUI()
  func setupInfo()
  func setupHealthKitInfo()
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
  private lazy var stepsImageView = UIImageView()
  private lazy var movementLabel = UILabel()
  private lazy var goalProgressLabel = UILabel()
  
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
    presenter.getHealthInfo()
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
  
  func setupHealthKitUI() {
    setupStepsImageView()
    setupMovementLabel()
    setupGoalProgressLabel()
  }
  
  func setupInfo() {
    navigationItem.title = presenter.navigationItemTitle
    titleLabel.text = presenter.title
    descriptionLabel.text = presenter.description
    goalLabel.text = presenter.goal
    typeLabel.text = presenter.type
    trophyLabel.text = presenter.trophy
    pointsLabel.text = presenter.points
    presenter.setViewDelegate(delegate: self)
  }
  
  func setupHealthKitInfo() {
    movementLabel.text = presenter.movement
    goalProgressLabel.text = presenter.percentage
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
  
  func setupStepsImageView() {
    stepsImageView.image = UIImage(systemName: "figure.walk")
    stepsImageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(stepsImageView)
    NSLayoutConstraint.activate([
      stepsImageView.topAnchor.constraint(equalTo: pointsLabel.bottomAnchor, constant: 48),
      stepsImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stepsImageView.heightAnchor.constraint(equalToConstant: 100),
      stepsImageView.widthAnchor.constraint(equalToConstant: 100)
    ])
  }
  
  func setupMovementLabel() {
    movementLabel.textColor = .systemCyan
    movementLabel.font = .boldSystemFont(ofSize: 24)
    movementLabel.textAlignment = .center
    movementLabel.adjustsFontSizeToFitWidth = true
    movementLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(movementLabel)
    NSLayoutConstraint.activate([
      movementLabel.topAnchor.constraint(equalTo: stepsImageView.bottomAnchor, constant: 12),
      movementLabel.centerXAnchor.constraint(equalTo: stepsImageView.centerXAnchor)
    ])
  }
  
  func setupGoalProgressLabel() {
    let heightAndWidth = 120.0
    goalProgressLabel.layer.borderColor = UIColor.systemCyan.cgColor
    goalProgressLabel.layer.borderWidth = 3
    goalProgressLabel.layer.cornerRadius = heightAndWidth / 2.0
    goalProgressLabel.textColor = .systemCyan
    goalProgressLabel.font = .boldSystemFont(ofSize: 24)
    goalProgressLabel.textAlignment = .center
    goalProgressLabel.adjustsFontSizeToFitWidth = true
    goalProgressLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(goalProgressLabel)
    NSLayoutConstraint.activate([
      goalProgressLabel.topAnchor.constraint(equalTo: movementLabel.bottomAnchor, constant: 48),
      goalProgressLabel.centerXAnchor.constraint(equalTo: movementLabel.centerXAnchor),
      goalProgressLabel.heightAnchor.constraint(equalToConstant: heightAndWidth),
      goalProgressLabel.widthAnchor.constraint(equalToConstant: heightAndWidth)
      
    ])
  }
  
  func showActivityIndicator(_ show: Bool = true) {
    activityIndicator.isHidden = !show
    show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
  }
}

// MARK: - ProgressPresenterDelegate

extension ProgressViewController: ProgressPresenterDelegate {
  func presentProgress(_ progress: Progress) {
    setupHealthKitUI()
    setupHealthKitInfo()
    presenter.saveProgress(progress)
  }
  
  func presentAlert(title: String, message: String) {
    DispatchQueue.main.async {
      self.showAlert(title: title, message: message)
    }
  }
}
