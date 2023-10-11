//
//  RocketsCell.swift
//  rocket-launches-programmatically
//
//  Created by Кирилл Васильев on 25.06.2023.
//

import UIKit
import SpaceXAPI
import SnapKit

// Класс RocketCell, наследуемый от UITableViewCell
class RocketCell: UITableViewCell {

    // Создаем лейблы для основного и второстепенного текста
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    // Инициализация ячейки и настройка представлений
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(_ rocket: RocketEntity) {
        nameLabel.text = rocket.name
        detailLabel.text = "Height: \(rocket.heightMeters) meters / Mass: \(rocket.massKg) kg"
    }

    // Функция для настройки представлений
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(detailLabel)
    }

    // Функция для настройки ограничений с использованием SnapKit
    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(15)
            make.right.lessThanOrEqualToSuperview().offset(-15)
        }

        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.right.equalTo(nameLabel)
            make.bottom.lessThanOrEqualToSuperview().offset(-15)
        }
    }
}


