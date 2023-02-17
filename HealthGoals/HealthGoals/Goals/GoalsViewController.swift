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
  //MARK: Objects
  private lazy var activityIndicator = UIActivityIndicatorView()
  private lazy var tableView = UITableView()
  
  // MARK: Variables
  private let coordinator: GoalsCoordinator
  private var goals = [
    Goal(id: 10001, goal: "500", description: "Walk 500 steps a day", title: "Easy walk steps", type: "step", reward: Reward(trophy: "bronze_medal", points: "5")),
    Goal(id: 10002, goal: "1000", description: "Walk 1000 steps a day", title: "Medium walk steps", type: "step", reward: Reward(trophy: "silver_medal", points: "10")),
    Goal(id: 10003, goal: "6000", description: "Walk 6000 steps a day", title: "Hard walk steps", type: "step", reward: Reward(trophy: "gold_medal", points: "20"))
  ]
  
  // MARK: Initializers
  init(coordinator: GoalsCoordinator) {
    self.coordinator = coordinator
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
    navigationItem.title = "Goals"
  }
}

// MARK: - Private methods

private extension GoalsViewController {
  func setupTableVIew() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(GoalsTableViewCell.self, forCellReuseIdentifier: GoalsTableViewCell.identifier)
    tableView.backgroundColor = .clear
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
      self.tableView.reloadData()
    }
  }
  
  func showActivityIndicator(_ show: Bool = true) {
    activityIndicator.isHidden = !show
    show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
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
    // TODO
  }
}
