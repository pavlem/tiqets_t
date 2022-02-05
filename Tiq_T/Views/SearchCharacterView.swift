
import SwiftUI
import NetworkProvider

struct SearchCharacterView: View {
    
    @FocusState private var isFocused: Bool
    @State private var name = ""
    @State private var isLoading = false
    @State private var isThereNoResults = false
    @State private var isEmptyText = false
    @ObservedObject var charactersVM: CharactersVM
    @ObservedObject var vm = SearchCharacterVM()
    @Environment(\.presentationMode) private var presentationMode
    
    private var infoText: String {
        if isEmptyText { return vm.emptyNameText }
        return isThereNoResults ? vm.noResultsText : vm.typeToSearchText
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Image(uiImage: vm.generalImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: vm.width, height: vm.height)
                        .clipped()
                        .cornerRadius(vm.corner)
                        .shadow(radius: vm.shadow)
                        .padding(.bottom)
                    ActivityIndicator(isAnimating: $isLoading, style: .large)
                }
                Text(infoText)
                TextField(vm.enterCharacterNameText, text: $name)
                    .focused($isFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            isFocused = true
                        }
                    }
                Button(vm.searchText) {
                    guard !name.isEmpty else {
                        isEmptyText = true
                        return
                    }
                    
                    isLoading = true
                    charactersVM.isSearchMode = true
                    
                    vm.search(for: name) { characters in
                        if characters.results.isEmpty {
                            isEmptyText = false
                            isThereNoResults = true
                            isLoading = false
                            charactersVM.resetAll()
                            return
                        }
                        charactersVM.characters = characters.results
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .padding(vm.padding)
            .font(.body)
            .offset(x: 0, y: -50)
        }
    }
}
