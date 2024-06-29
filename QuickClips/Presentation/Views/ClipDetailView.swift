//
//  ClipDetailView.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import SwiftUI
import AVKit

struct ClipDetailView: View {
    
    let userUrl = "https://ui-avatars.com/api/?name=John+Doe"
    let url = URL(string: "https://videos.pexels.com/video-files/1526909/1526909-hd_1280_720_24fps.mp4")
    
    @Environment(\.presentationMode) var presentationMode
    @State var player: AVPlayer?
    
    
    var body: some View {
        ZStack {
            Color(.primary).edgesIgnoringSafeArea(.all)
            VStack(spacing: 16) {
                VStack {
                    if let player = self.player {
                        VideoPlayer(player: player)
                            .onAppear {
                                player.play()
                            }
                            .frame(maxWidth: .infinity)
                            .edgesIgnoringSafeArea(.all)
                    } else {
                        Spacer()
                        ProgressView()
                            .tint(Color(.font))
                        Spacer()
                    }
                }
                Spacer()
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
                }.padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Clip")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color(.font))
            }
        })
        .onAppear {
            if let url = self.url {
                DispatchQueue.main.async {
                    self.player = AVPlayer(url: url)
                }
            }
        }
    }
}

#Preview {
    ClipDetailView()
}
