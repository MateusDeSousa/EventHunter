import UIKit
import mCore

class EventCardViewCell: UITableViewCell {
    
    //MARK: UI Components
    private let containerCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cardBackgroundColor
        return view
    }()
    
    private let eventCoverImageView: CachedImageView = {
        let imageView = CachedImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private let containerInfoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cardBackgroundColor
        view.clipsToBounds = false
        view.cornerRadius(of: 15)
        view.applyShadow(color: .black, opacity: 0.08, shadowOffset: CGSize(width: 0, height: -5), radius: 3)
        return view
    }()
    
    private let eventTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .labelColor
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let eventPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .systemBlue
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
    }()
    
    private let eventDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .labelColor
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            animateCard(zoomIn: isHighlighted)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        addSubviews()
        setupAnchors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		eventCoverImageView.image = nil
		eventTitleLabel.text = nil
		eventDateLabel.text = nil
		eventPriceLabel.text = nil
	}
    
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		containerCardView.cornerRadius(of: 15)
		containerCardView.applyShadowForRounded(offset: CGSize(width: 2, height: 2), radius: 8)
	}
	
    //MARK: Functions to build components in the view
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    private func addSubviews() {
        contentView.addSubview(containerCardView)
        containerCardView.addSubview(eventCoverImageView)
        containerCardView.addSubview(containerInfoView)
        
        containerInfoView.addSubview(eventTitleLabel)
        containerInfoView.addSubview(eventPriceLabel)
        containerInfoView.addSubview(eventDateLabel)
    }
    
    private func setupAnchors() {
        NSLayoutConstraint.activate([
            containerCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            eventCoverImageView.leadingAnchor.constraint(equalTo: containerCardView.leadingAnchor),
            eventCoverImageView.topAnchor.constraint(equalTo: containerCardView.topAnchor),
            eventCoverImageView.trailingAnchor.constraint(equalTo: containerCardView.trailingAnchor),
            eventCoverImageView.heightAnchor.constraint(equalToConstant: 120),
            
            containerInfoView.topAnchor.constraint(equalTo: containerCardView.topAnchor, constant: 100),
            containerInfoView.leadingAnchor.constraint(equalTo: containerCardView.leadingAnchor),
            containerInfoView.trailingAnchor.constraint(equalTo: containerCardView.trailingAnchor),
            containerInfoView.bottomAnchor.constraint(equalTo: containerCardView.bottomAnchor),
            
            eventTitleLabel.leadingAnchor.constraint(equalTo: containerInfoView.leadingAnchor, constant: 20),
            eventTitleLabel.topAnchor.constraint(equalTo: containerInfoView.topAnchor, constant: 20),
            
            eventPriceLabel.leadingAnchor.constraint(equalTo: eventTitleLabel.trailingAnchor, constant: 15),
            eventPriceLabel.topAnchor.constraint(equalTo: eventTitleLabel.topAnchor),
            eventPriceLabel.trailingAnchor.constraint(equalTo: containerInfoView.trailingAnchor, constant: -20),
            eventPriceLabel.widthAnchor.constraint(equalToConstant: 100),
            
            eventDateLabel.leadingAnchor.constraint(equalTo: eventTitleLabel.leadingAnchor),
            eventDateLabel.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor, constant: 10),
            eventDateLabel.trailingAnchor.constraint(equalTo: containerInfoView.trailingAnchor, constant: -20),
            eventDateLabel.bottomAnchor.constraint(equalTo: containerInfoView.bottomAnchor, constant: -20)
        ])
    }
    
    public func config(urlCover: URL?, title: String?, price: Double, date: Date) {
        eventCoverImageView.loadImage(from: urlCover, placeholderImage: UIImage(named: "emptyStateCover"), successCompletion: nil)
        eventTitleLabel.text = title
        eventPriceLabel.text = price.convertInMoney()
        eventDateLabel.text = date.format("dd/MMMM/yyyy")
    }
}

extension EventCardViewCell {
    
    private func animateCard(zoomIn: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.allowUserInteraction], animations: {
            self.containerCardView.transform = zoomIn ? CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9) : .identity
        }, completion: nil)
    }
}
