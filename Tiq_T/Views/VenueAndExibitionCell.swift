
import SwiftUI
import Foundation
import UIKit

struct VenueAndExibitionCell: View {
    
    @ObservedObject var vm: VenueAndExibitionCellVM
    
    var addOrRemove: (UUID)->Void
    
    var body: some View {
        NavigationLink(destination: VenueAndExibitionDetailView(vm: VenueAndExibitionDetailVM(venueAndExibitionVM: vm), addOrRemove: { uuid in
            addOrRemove(uuid)
            vm.isAddedToWish.toggle()
        })) {
            HStack {
                ZStack {
                    if vm.isAddedToWish { VenueAndExibitionFavoriteImage() }
                    VenueAndExibitionImageView(image: vm.image)
                }
                VStack(alignment: .leading) {
                    Text(vm.name)
                        .font(vm.titleFont)
                    Text(vm.type)
                    Text(vm.price)
                    Text(vm.additionalInfo)
                }
            }
        }
    }
}
