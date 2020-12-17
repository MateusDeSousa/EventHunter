//
//  DetailsEventViewCell.swift
//  EventHunter
//
//  Created by Mateus Sousa on 15/12/20.
//

import UIKit

protocol DetailsEventViewCellDelegate {
    func showLocationPressed()
    func checkinPressed()
}

class DetailsEventViewCell: UITableViewCell {
    
    //MARK: UI Components
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
        label.textColor = .systemBlue
        label.font = .boldSystemFont(ofSize: 16)
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
    
    private let buttonsFooterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 25
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let showLocationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ver no mapa", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.cornerRadius(of: 12)
        return button
    }()
    
    private let checkinButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Fazer check-in", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.cornerRadius(of: 12)
        return button
    }()
    
    var delegate: DetailsEventViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        addSubviews()
        setupAnchors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions to build components in the view
    private func setupSubviews() {
        selectionStyle = .none
        contentView.backgroundColor = .cardBackgroundColor
        backgroundColor = .clear
        showLocationButton.addTarget(self, action: #selector(onTapShowLocationButton), for: .touchUpInside)
        checkinButton.addTarget(self, action: #selector(onTapCheckinButton), for: .touchUpInside)
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(bodyStackView)
        contentView.addSubview(buttonsFooterStackView)
        
        bodyStackView.addArrangedSubview(descriptionLabel)
        bodyStackView.addArrangedSubview(dateLabel)
        
        buttonsFooterStackView.addArrangedSubview(showLocationButton)
        buttonsFooterStackView.addArrangedSubview(checkinButton)
    }
    
    private func setupAnchors() {
        let stackWidthWidth = UIScreen.main.bounds.width > 414 ? (414 * 0.866) : (UIScreen.main.bounds.width * 0.866)
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
            
            buttonsFooterStackView.widthAnchor.constraint(equalToConstant: stackWidthWidth),
            buttonsFooterStackView.heightAnchor.constraint(equalToConstant: 45),
            buttonsFooterStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonsFooterStackView.topAnchor.constraint(equalTo: bodyStackView.bottomAnchor, constant: 40),
            buttonsFooterStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
        ])
    }
    
    public func config(title: String?, price: Double, description: String?, date: Int) {
        titleLabel.text = title
        priceLabel.text = price.convertInMoney()
        descriptionLabel.text = description
        dateLabel.text = "Data do evento: " + date.convertInDate(format: "dd/MM/yyyy")
    }
}

extension DetailsEventViewCell {
    @objc private func onTapShowLocationButton() {
        delegate?.showLocationPressed()
    }
    
    @objc private func onTapCheckinButton() {
        delegate?.checkinPressed()
    }
    
    public func hiddenButttons(_ hidden: Bool) {
        buttonsFooterStackView.isHidden = hidden
    }
}
