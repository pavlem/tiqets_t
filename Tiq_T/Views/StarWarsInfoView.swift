
import SwiftUI

struct StarWarsInfoView: View {

    var vm: CharacterVM
    
    private let spacing = CGFloat(8)

    var body: some View {
        VStack(alignment: .leading, spacing: spacing, content: {
            StarWarsInfoSegmentView(descriptionTuple: (vm.nameTitle, vm.name))
            StarWarsInfoSegmentView(descriptionTuple: (vm.heightTitle, vm.height))
            StarWarsInfoSegmentView(descriptionTuple: (vm.hairTitle, vm.hairColor))
            StarWarsInfoSegmentView(descriptionTuple: (vm.birthTitle, vm.birthYear))
        })
    }
}

struct StarWarsDetailsInfoView: View {
        
    var vm: CharacterDetailVM
    
    private let spacing = CGFloat(8)
    private let fontTitle = Font.largeTitle.weight(.bold)
    private let fontValue = Font.largeTitle.weight(.light)

    var body: some View {
        VStack(alignment: .leading, spacing: spacing, content: {
            StarWarsInfoSegmentView(fontTitle: fontTitle, fontValue: fontValue, descriptionTuple: (vm.heightTitle, labelValue: vm.height))
            StarWarsInfoSegmentView(fontTitle: fontTitle, fontValue: fontValue, descriptionTuple: (vm.massTitle, labelValue: vm.mass))
            StarWarsInfoSegmentView(fontTitle: fontTitle, fontValue: fontValue, descriptionTuple: (vm.hairTitle, labelValue: vm.hairColor))
            StarWarsInfoSegmentView(fontTitle: fontTitle, fontValue: fontValue, descriptionTuple: (vm.skinTitle, labelValue: vm.skinColor))
            StarWarsInfoSegmentView(fontTitle: fontTitle, fontValue: fontValue, descriptionTuple: (vm.eyesTitle, labelValue: vm.eyeColor))
            StarWarsInfoSegmentView(fontTitle: fontTitle, fontValue: fontValue, descriptionTuple: (vm.birthTitle, labelValue: vm.birthYear))
        })
    }
}

struct StarWarsInfoSegmentView: View {
    
    private (set) var fontTitle = Font.headline.weight(.bold)
    private (set) var fontValue = Font.headline.weight(.light)
    private (set) var descriptionTuple: (labelDescription: String, labelValue: String)
    
    var body: some View {
        HStack {
            Text(descriptionTuple.labelDescription)
                .font(fontTitle)
            Text(descriptionTuple.labelValue)
                .font(fontValue)
        }
    }
}
