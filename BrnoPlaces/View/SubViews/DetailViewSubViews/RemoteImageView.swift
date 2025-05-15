//
//  RemoteImageView.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 11/05/2025.
//

import SwiftUI


struct RemoteImageView: View {
    let imageURL: String?
    let size: CGFloat

    @State private var imageData: Data?

    var body: some View {
        Group {
            if let data = imageData,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Image(systemName: Constants.Images.emptyPhoto)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray.opacity(0.9))
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.white, lineWidth: 3))
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        guard let imageURL, let url = URL(string: imageURL) else { return }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                await MainActor.run {
                    self.imageData = data
                }
            } catch {
                print("Image load error:", error)
            }
        }
    }
}


#Preview {
    RemoteImageView(
        imageURL: nil,
        size: 300
    )
}
