
import SwiftUI

struct VenueAndExibitionFavoriteImage: View {
    
    let vm = VenueAndExibitionFavoriteImageVM()

    var body: some View {
        Image(uiImage: vm.img)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: vm.width, height: vm.width)
            .clipped()
            .offset(x: vm.offsetX, y: vm.offsetY)
    }
}
