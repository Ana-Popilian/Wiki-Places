//
//  PlacesListLoadingSkeleton.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 20/06/2026.
//

import SwiftUI

struct PlacesListLoadingSkeleton: View {

  var isLoading: Bool

  var body: some View {
    LazyVStack(spacing: 16) {
      ForEach(0 ..< 5) { _ in
        PlacesListRow(model: .init(
          title: "---------",
          description: "--------",
          thumbnailImageUrl: nil,
          location: .init(latitude: 0, longitude: 0, spanDistance: 0)
        ), action: {})
      }
      .padding(.horizontal, 16)
    }
    .loadingShimmer(isLoading: isLoading)
  }
}

#Preview {
  PlacesListLoadingSkeleton(isLoading: true)
}
