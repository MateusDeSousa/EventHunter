//
//  CachedImageView.swift
//  EventHunter
//
//  Created by Mateus Sousa on 15/12/20.
//

import UIKit
import AFNetworking

public class CachedImageView: UIImageView {
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator: UIActivityIndicatorView
        if #available(iOS 13, *) {
            activityIndicator = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicator = UIActivityIndicatorView(style: .gray)
        }
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.frame = CGRect(
            x: 0, y: 0, width: bounds.width, height: bounds.height)
        activityIndicator.tintColor = .homeBackgroundColor
        
        return activityIndicator
    }()
    
    public static let imageCache = NSCache<NSString, DiscardableImageCacheItem>()
    public var shouldUseEmptyImage = true
    
    private var urlStringForChecking: String?
    private var emptyImage: UIImage?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        clipsToBounds = true
    }
    
    public func loadImage(from url: URL?, placeholderImage: UIImage? = nil, successCompletion: ((UIImage?) -> Void)? = nil) {
        image = nil
        emptyImage = placeholderImage
        
        guard let url = url else {
            image = emptyImage
            successCompletion?(image)
            return
        }
        
//        self.activityIndicator.embed(in: self)
        let urlRequest = URLRequest(url: url,
                                    cachePolicy: .returnCacheDataElseLoad,
                                    timeoutInterval: 60)
        
        let imageSerializer = AFImageResponseSerializer()
        imageSerializer.acceptableContentTypes?.insert("application/octet-stream")
        Self.sharedImageDownloader().sessionManager.responseSerializer = imageSerializer
        setImageWith(urlRequest, placeholderImage: nil, success: {
            [weak self] (_, httpResponse, image) in
            
            self?.activityIndicator.removeFromSuperview()
            
            // Não existe imagem no cache
            if httpResponse != nil {
                self?.alpha = 0.0
                self?.image = image
                UIView.animate(withDuration: 0.3, animations: {
                    self?.alpha = 1.0
                })
                // Existe imagem no cache, não executa a transição
            } else {
                self?.image = image
            }
            
            successCompletion?(self?.image)
        }, failure: { [weak self] (_, _, error) in
            self?.image = self?.emptyImage
        })
    }
}
