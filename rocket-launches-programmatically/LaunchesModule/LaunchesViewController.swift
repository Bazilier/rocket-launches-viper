//
//  LaunchesViewController.swift
//  rocket-launches-programmatically
//
//  Created by Кирилл Васильев on 25.06.2023.
//

import SpaceXAPI
import UIKit
import SnapKit

// Финальный класс LaunchesViewController
final class LaunchesViewController: UIViewController, LaunchesViewProtocol {
            
    // Переменная для хранения данных о ракете
    var rocket: RocketEntity!
    var presenter: LaunchesPresenterProtocol!
    
    // Создание форматеров для входной и выходной дат
    private let inDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter
    }()
     
    private let outDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return dateFormatter
    }()
    
    // Массивы для предстоящих и прошедших запусков
    private var launchesUpcoming: [LaunchEntity] = []
    private var launchesPast: [LaunchEntity] = []
    
    // Приватная переменная для таблицы с инициализацией замыканием
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.dataSource = self
        tv.delegate = self
        tv.register(LaunchCell.self, forCellReuseIdentifier: "LaunchCell")
        tv.allowsSelection = false
        return tv
    }()
    
    func setPresenter(_ presenter: LaunchesPresenterProtocol) {
        self.presenter = presenter
    }
    
    // Функция, вызываемая после загрузки представления контроллера
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = rocket.name
        
        // Настройка таблицы и загрузка данных о запусках
        setupViews()
        setupConstraints()
        print("ViewDidLoad called. Presenter is \(String(describing: presenter))")
        presenter.viewDidLoad()
    }
    
    // Функция для настройки представлений
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    // Функция для настройки ограничений с использованием SnapKit
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LaunchesViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Функция возвращающая количество секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Функция возвращающая количество ячеек в секции таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return launchesUpcoming.count
        case 1: return launchesPast.count
        default: return 0
        }
    }
    
    // Функция для конфигурации ячейки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath) as! LaunchCell
        let cellText: String
        let cellSecondaryText: String
        
        // Настройка ячеек в зависимости от секции
        switch indexPath.section {
        case 0:
            let launchUpcoming = launchesUpcoming[indexPath.row]
            cellText = launchUpcoming.missionName ?? ""
            let launchDate = inDateFormatter.date(from: launchUpcoming.launchDateUTC ?? "") ?? .now
            cellSecondaryText = outDateFormatter.string(from: launchDate)
            
        case 1:
            let launchPast = launchesPast[indexPath.row]
            cellText = launchPast.missionName ?? ""
            let launchDate = inDateFormatter.date(from: launchPast.launchDateUTC ?? "") ?? .now
            cellSecondaryText = outDateFormatter.string(from: launchDate)
            
        default:
            cellText = ""
            cellSecondaryText = ""
        }
        
        // Конфигурация ячейки
        cell.configureWith(text: cellText, secondaryText: cellSecondaryText)
        return cell
    }
    
    // Функция возвращающая заголовок для секции
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Upcoming launches"
        case 1: return "Past launches"
        default: return nil
        }
    }
}

extension LaunchesViewController {
    func displayLaunches(upcoming: [LaunchEntity], past: [LaunchEntity]) {
        print("View is showing \(upcoming.count) upcoming and \(past.count) past launches.")
        
        // Debug: Print first few elements of each array for verification
        if !upcoming.isEmpty {
            print("First upcoming launch: \(upcoming[0].missionName ?? "Unknown")")
        } else {
            print("No upcoming launches.")
        }
        
        if !past.isEmpty {
            print("First past launch: \(past[0].missionName ?? "Unknown")")
        } else {
            print("No past launches.")
        }

        self.launchesPast = past
        self.launchesUpcoming = upcoming
        tableView.reloadData()
    }
    
    func displayError(_ error: Error) {
        print(error.localizedDescription)
    }
}


