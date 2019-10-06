//
//  ImageDownloader.swift
//  EcommerceApp
//
//  Created by Sarathkumar S on 27/08/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import UIKit

typealias ImageDownloadHandler = (_ image: UIImage?, _ url: String, _ indexPath: IndexPath?, _ error: Error?) -> Void
typealias errorClosure = (_ error: String) -> Void

class ImageDownloadManager {
    
    static let shared = ImageDownloadManager()
    private init () {}
    let cache = NSCache<AnyObject, AnyObject>()
    
    // MARK: -  Download image from URL
    func downloadImage(url: String, index: IndexPath, completionHadler: @escaping ImageDownloadHandler) {
        /// if image is there in cache, get it
        if let cacheImage = self.cache.object(forKey: index.row + index.section as AnyObject) {
            completionHadler(cacheImage as? UIImage, url, index, nil)
        } else {
            /// start downloading from remote url
            let configuration = URLSessionConfiguration.default
            let urlSession = URLSession(configuration: configuration)
            let request = URLRequest(url: URL(string: url)!)
            urlSession.downloadTask(with: request, completionHandler: { (location, response, error) -> Void in
                guard let locationUr = location else {
                    return
                }
                if let data = try? Data(contentsOf: locationUr) {
                    DispatchQueue.main.async {
                        guard let img = UIImage(data: data) else {
                            return
                        }
                        /// Save the image in Cache
                        self.cache.setObject(img, forKey: index.row + index.section as AnyObject )
                        completionHadler(img, url, index, error)
                    }
                }
            }).resume()
        }
    }
}

