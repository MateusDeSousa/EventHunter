import UIKit

final class ErrorView: UIView {
	
	private let errorImageView: UIImageView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.contentMode = .scaleAspectFit
		return $0
	}(UIImageView())
	
	private let errorMessageLabel: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.font = .boldSystemFont(ofSize: 16)
		$0.textColor = .labelColor
		$0.textAlignment = .center
		$0.numberOfLines = 0
		return $0
	}(UILabel())
	
	init(illustration: UIImage?, message: String) {
		self.errorImageView.image = illustration
		self.errorMessageLabel.text = message
		super.init(frame: .zero)
		addSubviews()
		setupAnchors()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func addSubviews() {
		addSubview(errorImageView)
		addSubview(errorMessageLabel)
	}

	private func setupAnchors() {
		let errorImageViewCtn = [
			errorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			errorImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -60),
			errorImageView.heightAnchor.constraint(equalToConstant: 200),
			errorImageView.widthAnchor.constraint(equalToConstant: 200)
		]
		
		let errorMessageLabelCtn = [
			errorMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
			errorMessageLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 50),
			errorMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
		]
		
		NSLayoutConstraint.activate([errorImageViewCtn, errorMessageLabelCtn].flatMap{$0})
	}
	
}
