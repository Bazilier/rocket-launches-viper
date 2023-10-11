//  RocketsViewController.swift
//  rocket-launches-programmatically
//
//  Created by Кирилл Васильев on 12.08.2023.
//

import UIKit

final class RocketsViewController: UIViewController, RocketsViewProtocol {

    private var rockets: [RocketEntity] = []
    var presenter: RocketsPresenterProtocol?
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.dataSource = self
        tv.delegate = self
        tv.register(RocketCell.self, forCellReuseIdentifier: "RocketCell")
        return tv
    }()
    
    // Dependency Injection
    func setPresenter(_ presenter: RocketsPresenterProtocol) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        presenter?.viewDidLoad()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource
extension RocketsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rockets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RocketCell", for: indexPath) as! RocketCell
        let rocket = rockets[indexPath.row]
        cell.configureWith(rocket)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RocketsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Rockets"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row) was tapped.")
        presenter?.didSelectRocket(at: indexPath.row)
    }
}

// MARK: - RocketsPresenterOutput Implementation
extension RocketsViewController {
    func displayRockets(_ rockets: [RocketEntity]) {
        self.rockets = rockets
        tableView.reloadData()
    }
    
    func displayError(_ error: Error) {
        // Here, you can implement a more user-friendly error display (like an alert or a banner).
        print(error.localizedDescription)
    }
}
