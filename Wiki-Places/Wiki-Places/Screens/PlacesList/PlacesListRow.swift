//
//  PlacesListRow.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 20/06/2026.
//

import SwiftUI

struct PlacesListRow: View {

  let model: Model.Place
  let action: () -> Void

  private(set) var imageSize: CGFloat = 76

  var body: some View {
    Button {
      action()
    } label: {
      HStack {
        VStack(alignment: .leading) {
          HStack {
            if let imageUrl = model.thumbnailImageUrl {
              imageView(imageUrl)
            } else {
              placeholder
            }

            VStack(alignment: .leading) {
              Text(model.title)
                .font(.headline)
                .foregroundStyle(.black)
                .multilineTextAlignment(.leading)

              if let description = model.description {
                Text(description)
                  .font(.subheadline)
                  .foregroundStyle(.gray)
                  .multilineTextAlignment(.leading)
                  .lineLimit(3)
              }
            }
            .frame(maxHeight: 90)
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
    .padding(16)
    .background {
      RoundedRectangle(cornerRadius: 16)
        .fill(.white)
    }
  }
}

// MARK: - Private extension

private extension PlacesListRow {
  func imageView(_ url: URL) -> some View {
    AsyncImage(url: url, transaction: Transaction(animation: .easeIn)) { phase in
      switch phase {
      case let .success(image):
        successView(with: image)

      case .failure:
        failureView

      default:
        ProgressView()
          .controlSize(.large)
          .frame(width: imageSize, height: imageSize)
      }
    }
  }

  func successView(with image: Image) -> some View {
    image
      .resizable()
      .scaledToFill()
      .frame(width: imageSize, height: imageSize)
      .clipShape(RoundedRectangle(cornerRadius: 16))
  }

  var failureView: some View {
    RoundedRectangle(cornerRadius: 16)
      .fill(.gray).opacity(0.2)
      .frame(width: imageSize, height: imageSize)
      .overlay {
        Image(systemName: "photo.badge.exclamationmark")
          .font(.system(size: imageSize / 2))
          .tint(.red)
      }
      .frame(height: imageSize)
  }

  var placeholder: some View {
    RoundedRectangle(cornerRadius: 16)
      .fill(.gray).opacity(0.2)
      .frame(width: imageSize, height: imageSize)
      .overlay {
        Image(systemName: "photo.fill")
          .font(.system(size: imageSize / 2))
          .tint(.blue)
      }
      .frame(height: imageSize)
  }
}

#Preview {
  VStack(spacing: 16) {
    PlacesListRow(
      model: .init(
        title: "Amsterdam",
        description: "Capital of the Netherlands",
        thumbnailImageUrl: URL(string: "https://fastly.picsum.photos/id/146/5000/3333.jpg?hmac=xdlFnzoavokA3U-bzo35Vk4jTBKx8C9fqH5IuCPXj2U")!,
        location: .init(
          latitude: 52.33739,
          longitude: 4.87527,
          spanDistance: 10_000
        )
      ),
      action: {}
    )

    PlacesListRow(
      model: .init(
        title: "Paris",
        description: "Capital of France and land of croissants",
        thumbnailImageUrl: URL(string: "https://cdn2.thecatapi.com/ima7e/3cf.jpg")!,
        location: .init(
          latitude: 48.8575,
          longitude: 2.3514,
          spanDistance: 10_000
        )
      ),
      action: {}
    )

    PlacesListRow(
      model: .init(
        title: "Rome",
        description: "Capital of Italy",
        thumbnailImageUrl: nil,
        location: .init(
          latitude: 41.8967,
          longitude: 12.4822,
          spanDistance: 10_000
        )
      ),
      action: {}
    )
    Spacer()
  }
  .padding(.horizontal, 16)
  .background(.mint)
}
