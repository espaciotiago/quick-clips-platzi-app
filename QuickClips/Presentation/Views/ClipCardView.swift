//
//  ClipCardView.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import SwiftUI

struct ClipCardView: View {
    let userUrl = "https://ui-avatars.com/api/?name=John+Doe"
    let imageUrl = "https://images.pexels.com/videos/1526909/free-video-1526909.jpg?auto=compress&cs=tinysrgb&fit=crop&h=630&w=1200"
    let clipSelected: () -> Void
    let profileSelected: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Button(action: {
                // TODO: Handle
            }, label: {
                ZStack {
                    UrlImageView(urlString: self.imageUrl)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    Image(.playButton)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color(.placeholder))
                        .frame(width: 40, height: 40)
                }
            })
            HStack {
                UrlImageView(urlString: self.userUrl)
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                Text("Jhon Doe")
                    .font(.subheadline)
                    .foregroundStyle(Color(.font))
                Spacer()
                CustomButtonView(label: "Ver perfil") {
                    // TODO: Handle
                }
            }
        }
    }
}

#Preview {
    ClipCardView(clipSelected: {}, profileSelected: {})
        .padding()
        .background(Color(.primary))
}
