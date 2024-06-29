//
//  CustomButtonView.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import SwiftUI

struct CustomButtonView: View {
    
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            VStack {
                Text(self.label)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.font))
            }
            .padding(.vertical, 4)
            .padding(.horizontal)
            .background(Color(.secondary).cornerRadius(16))
        })
    }
}

#Preview {
    CustomButtonView(label: "Button") {}
}
