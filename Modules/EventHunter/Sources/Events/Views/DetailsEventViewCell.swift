//
//  DetailsEventViewCell.swift
//  EventHunter
//
//  Created by Mateus Sousa on 15/12/20.
//

import UIKit

class DetailsEventViewCell: UITableViewCell {
    
    private let bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 25
        stackView.distribution = .fill
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textColor = .labelColor
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .labelColor
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .secondaryLabelColor
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabelColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        addSubviews()
        setupAnchors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func config(title: String?, price: Double, description: String?, date: Int) {
        titleLabel.text = title
        priceLabel.text = price.convertInMoney()
        descriptionLabel.text = description
        dateLabel.text = "Data do evento: " + date.convertInDate(format: "dd/MM/yyyy")
    }
    
    private func setupSubviews() {
        selectionStyle = .none
        contentView.backgroundColor = .cardBackgroundColor
        backgroundColor = .clear
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(bodyStackView)
        
        bodyStackView.addArrangedSubview(descriptionLabel)
        bodyStackView.addArrangedSubview(dateLabel)
    }
    
    private func setupAnchors() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            priceLabel.widthAnchor.constraint(equalToConstant: 100),
            
            bodyStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            bodyStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            bodyStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            bodyStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}

