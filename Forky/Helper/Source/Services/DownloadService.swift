//
//  DownloadService.swift
//  
//
//  Created by Prakhar Pandey on 26/07/22.
//

import UIKit
import WebKit

fileprivate enum ImageType {
    case jpeg
    case svg
    case pdf
    case png
    
    init?(url: URL) {
        let pathExtension = url.pathExtension
        switch pathExtension {
        case "jpeg", "jpg": self = .jpeg
        case "svg": self = .svg
        case "pdf": self = .pdf
        case "png": self = .png
        default:
            return nil
        }
    }
}

/// This is the download service to download images and it can also extend for other types of download
@available(iOS 13.0, *)
final class DownloadService {
    
    static let `default` = DownloadService()
    
    private init() {}
    
    func downloadImage(_ urlString: String?, in imageView: UIImageView?) async {
        guard let imageView = imageView else {
            let logParam = LogParam(error: URLServiceError.message("ImageView is nil") as NSError)
            Logger.log(logParam)
            return
        }
        
        guard let urlString = urlString, let url = URL(string: urlString) else {
            let logParam = LogParam(error: URLServiceError.invalidURL as NSError)
            Logger.log(logParam)
            return
        }
        
        guard let imageType = ImageType(url: url) else {
            let logParam = LogParam(error: URLServiceError.unsupportedImageType as NSError)
            Logger.log(logParam)
            return
        }
        
        await showImage(imageType, imageView: imageView, url: url)
    }
    
    @MainActor
    private func showImage(_ imageType: ImageType, imageView: UIImageView, url: URL) async {
        imageView.image = nil

        switch imageType {
        case .jpeg, .png:
            Task.detached(priority: .background) { [weak self] in
                let data = await self?.pngOrJPEG(url)
                await MainActor.run(body: {
                    if let data = data {
                        imageView.image = UIImage(data: data)
                    } else {
                        imageView.image = nil
                    }
                })
            }
        case .svg:
            await svg(url, imageView: imageView)
        case .pdf:
            imageView.image = await pdf(url)
        }
    }
  
    private func pngOrJPEG(_ url: URL) async -> Data? {
        let request = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(from: request)
            return data
        } catch {
            let logParam = LogParam(error: error as NSError)
            Logger.log(logParam)
            return nil
        }
    }
    
    @MainActor
    private func pdf(_ url: URL) async -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else {
            let logParam = LogParam(error: URLServiceError.invalidURL as NSError)
            Logger.log(logParam)
            return nil
        }
        guard let page = document.page(at: 1) else {
            let logParam = LogParam(error: URLServiceError.invalidPDF as NSError)
            Logger.log(logParam)
            return nil
        }
        
        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let image = renderer.image { context in
            UIColor.white.set()
            context.fill(pageRect)
            context.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            context.cgContext.scaleBy(x: 1.0, y: -1.0)
            context.cgContext.drawPDFPage(page)
        }
        
        return image
    }
    
    @MainActor
    private func svg(_ url: URL, imageView: UIImageView) async {
        imageView.layoutIfNeeded()
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        let webView: WKWebView = WKWebView(frame: .zero, configuration: configuration)
        let contentMode = imageView.contentMode
        let backgroundColor = imageView.backgroundColor
        
        let str = "<html><header><meta name='viewport' content='width=\(imageView.frame.width),height=\(imageView.frame.height), initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0'></header><body style='margin: auto;' align='\(getImageAlignment(contentMode))'><img src=\"\(url)\"style=\"width:\(imageView.frame.width)px;height:\(imageView.frame.width)px;\"></body></html>"
        webView.contentMode = contentMode
        webView.layer.borderWidth = 0.0
        webView.layer.backgroundColor = backgroundColor?.cgColor
        webView.isOpaque = false
        webView.backgroundColor = backgroundColor
        webView.scrollView.backgroundColor = backgroundColor
        webView.loadHTMLString(str, baseURL: nil)
        webView.isUserInteractionEnabled = false
        webView.frame = imageView.bounds
        
        /* Remove any added subview */
        imageView.subviews.forEach{
            $0.removeFromSuperview()
        }
        imageView.addSubview(webView)
    }
}

@available(iOS 13.0, *)
extension DownloadService {
    func getImageAlignment(_ contentMode: UIView.ContentMode) -> String {
        switch contentMode {
        case .left:
            return "left"
        case .right:
            return "right"
        default:
            return "center"
        }
    }
}
