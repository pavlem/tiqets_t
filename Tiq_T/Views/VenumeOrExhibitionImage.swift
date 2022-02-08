//
//  VenumeOrExhibitionImage.swift
//  Tiq_T
//
//  Created by Pavle Mijatovic on 8.2.22..
//

import SwiftUI

struct VenumeOrExhibitionImage: View {
    
    @State var contentMode = ContentMode.fit
    @State  var isFull = false
    
    var uiImage: UIImage
    
    var body: some View {
        HStack {
            VStack {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .padding()
                    .onTapGesture {
                        withAnimation {
                            isFull.toggle()
                            contentMode = isFull ? ContentMode.fill : ContentMode.fit
                        }
                    }
            }
        }
        .background(Color(UIColor.systemBackground))
    }
}
