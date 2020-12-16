//
//  FormCheckinViewModel.swift
//  EventHunter
//
//  Created by Mateus Sousa on 16/12/20.
//

import UIKit
import mNetwork

class FormCheckinViewModel: EventViewModel {
    
    var refController: UIViewController?
    var customView: UIView
    
    private let eventId: String
    private var nameUser: String = ""
    private var emailUser: String = ""
    
    init(eventId: String) {
        self.eventId = eventId
        self.customView = FormCheckinCustomView()
    }
    
    func viewDidLoad() {
        setViewDelegate()
    }
    
    func setupNavigation(_ navigation: UINavigationController?) {
        
    }
    
    private func setViewDelegate() {
        (customView as? FormCheckinCustomView)?.delegate = self
    }
    
    private func runCheckin(id: Int, name: String, email: String) {
        let api = APIRepository()
        api.checkinEvent(at: id, name: name, email: email) {[weak self] error in
            DispatchQueue.main.async {
                if let _ = error {
                    self?.showDialogError(titleError: "Erro", messageError: "Error ao fazer check-in, verifique sua conexão e tente novamente!")
                }else {
                    (self?.customView as? FormCheckinCustomView)?.startCompleteCheckin()
                }
            }
            
        }
    }
    
    private func toValidFields() -> Bool {
        if nameUser.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showDialogError(titleError: "Campo vazio", messageError: "Preencha corretamente o seu nome para prosseguir")
            return false
        }else if !emailUser.isValidEmail() {
            showDialogError(titleError: "Email incorreto", messageError: "Preencha corretamente o seu email para continuar")
            return false
        }else {
            return true
        }
    }
    
    private func showDialogError(titleError: String, messageError: String) {
        let alertController = UIAlertController(title: titleError, message: messageError, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Entendi", style: .default, handler: nil))
        refController?.present(alertController, animated: true, completion: nil)
    }
}

extension FormCheckinViewModel: FormCheckinCustomViewDelegate {
    func closeButtonPressed() {
        refController?.dismiss(animated: true, completion: nil)
    }
    
    func nameFieldDidChange(_ text: String) {
        nameUser = text
    }
    
    func emailFieldDidChange(_ text: String) {
        emailUser = text
    }
    
    func doneButtonPressed() {
        guard let id = Int(eventId), toValidFields() else { return }
        runCheckin(id: id, name: nameUser, email: emailUser)
    }
}
