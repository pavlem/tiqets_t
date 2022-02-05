
import SwiftUI

struct OfferingsMainView: View {
    
    @State private var showModal: Bool = false
    @State private var searchText = ""
    @ObservedObject var charactersVM = CharactersVM()
    
    private let companyTitle = "Characters..."
    private let searchTitle = "Search"
    private let resetTitle = "Reset"

    var body: some View {
        
        LoadingView(isShowing: $charactersVM.isLoading) {
            NavigationView {
                VStack() {
                    List {
                        ForEach(filteredCharacters) { character in
                            StarWarsCharacterCell(vm: CharacterVM(character: character))                                   }
                        Button(action: {}) { Text("") }
                        .onAppear {
                            if charactersVM.isSearchMode == false {
                                DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 10)) {
                                    charactersVM.loadMore()
                                }
                            }
                           
                        }
                    }
                }
                .searchable(text: $searchText)
                .navigationTitle(companyTitle)
                .toolbar {
                    HStack {
                        Button(resetTitle) { charactersVM.resetAll() }
                        Button(searchTitle) {
                            self.showModal = true
                        }.sheet(isPresented: self.$showModal) {
                        } content: {
                            SearchCharacterView(charactersVM: charactersVM)
                        }
                    }
                }
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    var filteredCharacters: [Character] {
        guard searchText.isEmpty else { return charactersVM.characters.filter { $0.name.contains(searchText) } }
        return charactersVM.characters
    }
}

