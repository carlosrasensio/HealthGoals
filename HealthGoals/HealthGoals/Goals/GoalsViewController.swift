//
//  GoalsViewController.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import UIKit

protocol GoalsViewControllerProtocol {
  func setupUI()
  func setupInfo()
}

final class GoalsViewController: UIViewController {
  // MARK: Objects
  private lazy var activityIndicator = UIActivityIndicatorView()
  private lazy var tableView = UITableView()
  
  // MARK: Variables
  private let presenter: GoalsPresenterProtocol
  
  private var goals = [Goal]()
  
  // MARK: Initializers
  init(presenter: GoalsPresenterProtocol) {
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

// MARK: - GoalsViewControllerProtocol

extension GoalsViewController: GoalsViewControllerProtocol {
  func setupUI() {
    view.backgroundColor = .white
    setupTableVIew()
    setupActivityIndicator()
  }
  
  func setupInfo() {
    navigationItem.title = presenter.navigationItemTitle
    presenter.setViewDelegate(delegate: self)
    getGoals()
  }
}

// MARK: - Private methods

private extension GoalsViewController {
  func setupTableVIew() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(GoalsTableViewCell.self, forCellReuseIdentifier: GoalsTableViewCell.identifier)
    tableView.separatorStyle = .none
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
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
  
  func reloadTableView() {
    DispatchQueue.main.async {
      self.showActivityIndicator()
      self.tableView.reloadData()
      self.showActivityIndicator(false)
    }
  }
  
  func showActivityIndicator(_ show: Bool = true) {
    activityIndicator.isHidden = !show
    show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
  }
  
  func getGoals() {
    Task {
      await presenter.getGoals()
    }
  }
}

// MARK: - UITableViewDataSource

extension GoalsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    goals.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: GoalsTableViewCell.identifier, for: indexPath) as! GoalsTableViewCell
    cell.setupInfo(with: goals[indexPath.row])
    
    return cell
  }
}

// MARK: - UITableViewDelegate

extension GoalsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.didSelectGoal(goals[indexPath.row])
  }
}

// MARK: - GoalsPresenterDelegate

extension GoalsViewController: GoalsPresenterDelegate {
  func presentGoals(_ goals: [Goal]) {
    self.goals = goals
    reloadTableView()
  }
  
  func presentAlert(title: String, message: String) {
    DispatchQueue.main.async {
      self.showAlert(title: title, message: message)
    }
  }
}
