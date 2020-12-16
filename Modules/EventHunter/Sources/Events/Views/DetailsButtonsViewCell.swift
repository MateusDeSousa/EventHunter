//
//  DetailsButtonsViewCell.swift
//  EventHunter
//
//  Created by Mateus Sousa on 16/12/20.
//

import UIKit

protocol DetailsButtonsViewCellDelegate {
    func showLocationPressed()
    func checkinPressed()
}

class DetailsButtonsViewCell: UITableViewCell {
    
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
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.cornerRadius(of: 12)
        return button
    }()
    
    private let checkinButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Fazer check-in", for: .normal)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.cornerRadius(of: 12)
        return button
    }()
    
    var delegate: DetailsButtonsViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        addSubviews()
        setupAnchors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        selectionStyle = .none
        backgroundColor = .cardBackgroundColor
        contentView.backgroundColor = .cardBackgroundColor
        showLocationButton.addTarget(self, action: #selector(onTapShowLocationButton), for: .touchUpInside)
        checkinButton.addTarget(self, action: #selector(onTapCheckinButton), for: .touchUpInside)
    }
    
    private func addSubviews() {
        contentView.addSubview(buttonsFooterStackView)
        buttonsFooterStackView.addArrangedSubview(showLocationButton)
        buttonsFooterStackView.addArrangedSubview(checkinButton)
    }
    
    private func setupAnchors() {
        let stackWidthWidth = UIScreen.main.bounds.width > 414 ? (414 * 0.866) : (UIScreen.main.bounds.width * 0.866)
        NSLayoutConstraint.activate([
            buttonsFooterStackView.widthAnchor.constraint(equalToConstant: stackWidthWidth),
            buttonsFooterStackView.heightAnchor.constraint(equalToConstant: 45),
            buttonsFooterStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonsFooterStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            buttonsFooterStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
        ])
    }
    
    @objc private func onTapShowLocationButton() {
        delegate?.showLocationPressed()
    }
    
    @objc private func onTapCheckinButton() {
        delegate?.checkinPressed()
    }
}
