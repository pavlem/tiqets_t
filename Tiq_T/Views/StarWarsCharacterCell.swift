
import SwiftUI
import Foundation
import UIKit

struct StarWarsCharacterCell: View {
    
    @ObservedObject var vm: CharacterVM
    private let imageFrameWidth = CGFloat(100)
    private let spacing = CGFloat(8)
    
    var body: some View {
        
        NavigationLink(destination: StarWarsCharacterDetailView(vm: CharacterDetailVM(character: vm.character))) {
            HStack {
                ZStack {
                    if vm.isFavorite {
                        StarWarsFavoriteImage()
                        StarWarsIconImageView(image: vm.image)

                    } else {
                        StarWarsIconImageView(image: vm.image)
                    }
                }
                StarWarsInfoView(vm: vm)
            }
        }
    }
}
