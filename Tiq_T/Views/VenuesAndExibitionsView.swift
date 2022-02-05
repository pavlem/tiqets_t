
import SwiftUI

struct VenuesAndExibitionsView: View {
    
    @State private var searchText = ""
    @State private var isWishVenue = false
    @ObservedObject var vm = VenuesAndExibitionsVM(venueAndExibitionRepo: VenueAndExibitionLocal())
    
    var body: some View {
        LoadingView(isShowing: $vm.isLoading) {
            NavigationView {
                VStack() {
                    List {
                        ForEach(venuesAndExibitions) { venueAndExibition in
                            VenueAndExibitionCell(vm: venueAndExibition) { uuid in
                                vm.addOrRemoveToWishes(uuid: uuid)
                            }
                        }
                    }
                }
                .searchable(text: $searchText)
                .navigationTitle(vm.companyTitle)
                .toolbar {
                    HStack {
                        Button(isWishVenue ? vm.seeAllButtonTitle : vm.wishListButtonTitle) {
                            isWishVenue.toggle()
                        }
                    }
                }
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    var venuesAndExibitions: [VenueAndExibitionCellVM] {
        guard searchText.isEmpty else {
            let venuesAndExibitons = isWishVenue ? vm.venuesAndExibitionsWishes : vm.venuesAndExibitions
            return filter(venuesAndExibitons: venuesAndExibitons, forSearchText: searchText)
        }
        
        return isWishVenue ? vm.venuesAndExibitionsWishes : vm.venuesAndExibitions
    }
    
    func filter(venuesAndExibitons: [VenueAndExibitionCellVM], forSearchText searchText: String) -> [VenueAndExibitionCellVM] {
        let textToSearch = searchText.lowercased()

        return venuesAndExibitons.filter {
            $0.name.lowercased().contains(textToSearch) ||
            $0.type.lowercased().contains(textToSearch) ||
            $0.price.lowercased().contains(textToSearch)
        }
    }
}
