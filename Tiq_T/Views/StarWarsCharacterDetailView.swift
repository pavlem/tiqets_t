
import SwiftUI

struct StarWarsCharacterDetailView: View {
    
    @ObservedObject var vm: CharacterDetailVM
    
    var body: some View {
        VStack {
            Image(uiImage: vm.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: vm.imageFrameWidth, height: vm.imageFrameWidth)
                .clipped()
                .cornerRadius(vm.cornerRadius)
                .shadow(radius: vm.shadowRadius)
                .padding(.bottom)
            ScrollView {
                StarWarsDetailsInfoView(vm: vm)
            }
            Divider()
            Text(vm.starshipsTitleText)
                .font(.title)
                .multilineTextAlignment(.center)
            Text(vm.startships ?? "")
            Divider()
            Button(vm.isFavoriteText) {
                vm.isFavorite = !vm.isFavorite
            }
        }
        .padding().navigationBarTitle(Text(vm.name), displayMode: .inline)
        .onAppear {
            vm.fetchStarships()
        }
    }
}
