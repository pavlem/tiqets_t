
import SwiftUI

struct VenueAndExibitionDetailView: View {
    
    @ObservedObject var vm: VenueAndExibitionDetailVM
    
    var addOrRemove: (UUID)->Void
    
    var body: some View {
        VStack {
            NavigationLink(destination: VenumeOrExhibitionImage(uiImage: vm.image)) {
                Image(uiImage: vm.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: vm.imageFrameWidth, height: vm.imageFrameWidth)
                    .clipped()
                    .cornerRadius(vm.cornerRadius)
                    .shadow(radius: vm.shadowRadius)
                    .padding(.bottom)
            }
            ScrollView {
                Text(vm.details)
                    .font(Font.largeTitle.weight(.bold))
            }
            Button(vm.isAddedToAWishlist ? vm.removeTitle : vm.addTitle) {
                vm.isAddedToAWishlist.toggle()
                addOrRemove(vm.id)
            }
        }
        .padding().navigationBarTitle(Text(vm.title), displayMode: .inline)
    }
}
