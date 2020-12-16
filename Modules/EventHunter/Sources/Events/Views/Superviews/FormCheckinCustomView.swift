//
//  FormCheckinCustomView.swift
//  EventHunter
//
//  Created by Mateus Sousa on 16/12/20.
//

import UIKit
import mCore

class FormCheckinCustomView: UIView {
    
    private let closeButton: CircleButtonView = {
        let button = CircleButtonView()
        button.setup(type: .close)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Insira seus dados abaixo para continuar com o check-in"
        label.font = .boldSystemFont(ofSize: 21)
        label.textColor = .labelColor
        label.numberOfLines = 0
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Nome"
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "E-mail"
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Concluir", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = .systemBlue
        button.cornerRadius(of: 12)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        addSubviews()
        setupAnchors()
        closeButton.setPositionTopLeft()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        backgroundColor = .cardBackgroundColor
        doneButton.addTarget(self, action: #selector(onTapDoneButton), for: .touchUpInside)
    }
    
    @objc private func onTapDoneButton() {
        validFields()
    }
    
    private func validFields() -> Void {
        
    }
    
//    private func runCheckin(id: Int, name: String, email: String) {
//        let api = APIRepository()
//        api.checkinEvent(at: id, name: name, email: email) { error in
//            if let error = error {
//
//            }else {
//
//            }
//        }
//    }
    
    private func addSubviews() {
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(doneButton)
    }
    
    private func setupAnchors() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            doneButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            doneButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            doneButton.widthAnchor.constraint(equalToConstant: 180),
            doneButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
