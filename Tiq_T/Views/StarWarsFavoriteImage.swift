
import SwiftUI

struct StarWarsFavoriteImage: View {
    
    private let img = UIImage(named: "starImg")!
    private let width = CGFloat(30)
    private let offsetX = CGFloat(-50)
    private let offsetY = CGFloat(-45)

    var body: some View {
        
        Image(uiImage: img)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: width)
            .clipped()
            .offset(x: offsetX, y: offsetY)
    }
}
