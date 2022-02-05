
import SwiftUI

struct VenueAndExibitionImageView: View {
    
    var image: UIImage
    
    private let imageFrameWidth = CGFloat(100)
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: imageFrameWidth, height: imageFrameWidth)
            .clipped()
            .cornerRadius(imageFrameWidth / 2)
    }
}
