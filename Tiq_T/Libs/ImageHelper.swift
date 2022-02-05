
import UIKit

class ImageHelper {
    
    // MARK: - API
    static let shared = ImageHelper()
    var imageCache = NSCache<NSString, UIImage>()
    
    func cache(image: UIImage, key: String) {
        ImageHelper.shared.imageCache.setObject(image, forKey: key as NSString)
    }
}
