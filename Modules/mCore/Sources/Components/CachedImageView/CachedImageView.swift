//
//  CachedImageView.swift
//  EventHunter
//
//  Created by Mateus Sousa on 15/12/20.
//

import UIKit
import AFNetworking

public class CachedImageView: UIImageView {
    
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
        image = emptyImage
        
        guard let url = url else {
            successCompletion?(image)
            return
        }
        
        let urlRequest = URLRequest(url: url,
                                    cachePolicy: .returnCacheDataElseLoad,
                                    timeoutInterval: 60)
        
        let imageSerializer = AFImageResponseSerializer()
        imageSerializer.acceptableContentTypes?.insert("application/octet-stream")
        Self.sharedImageDownloader().sessionManager.responseSerializer = imageSerializer
        setImageWith(urlRequest, placeholderImage: nil, success: {
            [weak self] (_, httpResponse, image) in
            
            // not found cache image
            if httpResponse != nil {
                self?.alpha = 0.0
                self?.image = image
                UIView.animate(withDuration: 0.3, animations: {
                    self?.alpha = 1.0
                })
            } else {
                self?.image = image
            }
            
            successCompletion?(self?.image)
        }, failure: { [weak self] (_, _, error) in
            self?.image = self?.emptyImage
        })
    }
}
