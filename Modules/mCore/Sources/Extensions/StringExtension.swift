import Foundation

public extension String {
	
	init(localized string: String) {
		let localized = NSLocalizedString(string, comment: "")
		self.init(localized)
	}
	
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
