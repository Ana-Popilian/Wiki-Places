//
//  PlaceView.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 20/06/2026.
//

import MapKit
import SwiftUI

struct PlaceView: View {
  @Bindable private var viewModel: PlaceViewModel

  init(_ viewModel: PlaceViewModel = PlaceViewModel()) {
    self._viewModel = Bindable(viewModel)
  }

  var body: some View {
    NavigationStack {
      MapReader { proxy in
        Map(position: $viewModel.position) {
          if let tappedCoordinate = viewModel.tappedCoordinate {

            Marker("", coordinate: tappedCoordinate)
          }
        }
        .onTapGesture { position in
          if let coordinate = proxy.convert(position, from: .local) {
            didTap(coordinate: coordinate)
          }
        }
        .onChange(of: viewModel.tappedCoordinate) {
          withAnimation(.easeInOut(duration: 1)) {
            if let coordinate = viewModel.tappedCoordinate {
              let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
              viewModel.position = .region(region)
            }
          }
        }
        .overlay(alignment: .bottom) {
          VStack(spacing: 16) {
            if viewModel.isDiscoverOnWikipediaButtonVisible {
              discoverInWikipediaButton {
                viewModel.discoverInWikipedia()
              }
            }
            searchButton
          }
        }
        .navigationDestination(isPresented: $viewModel.isSearchListPresented) {
          PlacesListView(
            didTapLocation: { location in
              viewModel.isSearchListPresented = false

              didTap(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
            }
          )
        }
      }
    }
  }
}

#Preview {
  PlaceView()
}

// MARK: - Private extension
private extension PlaceView {

  func didTap(coordinate: CLLocationCoordinate2D) {
    Task { @MainActor in
      viewModel.isDiscoverOnWikipediaButtonVisible = true
      viewModel.tappedCoordinate = coordinate

      viewModel.didTapOnMap(
        latitude: coordinate.latitude,
        longitude: coordinate.longitude
      )

      print("Latitude: \(coordinate.latitude)")
      print("Longitude: \(coordinate.longitude)")
    }
  }

  var searchButton: some View {
    Button {
      viewModel.didTapSearchButton()
    } label: {
      HStack {
        Image(systemName: "magnifyingglass")
          .foregroundStyle(.black.opacity(0.8))

        Text("Search places")
          .foregroundStyle(.black.opacity(0.8))
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(16)
      .background(.white.opacity(0.8))
      .clipShape(RoundedRectangle(cornerRadius: 36))
      .padding(.horizontal, 16)
    }
  }

  func discoverInWikipediaButton(action: @escaping () -> Void) -> some View {
    Button {
      action()
    } label: {
      Text("Discover on Wikipedia")
        .foregroundStyle(.white)
        .font(.title2)
        .padding()

        .padding(.horizontal, 16)
        .background(
          RoundedRectangle(cornerRadius: 36)
            .opacity(0.7)
        )
    }
    .padding(.bottom, 36)
    .accessibilityLabel("Discover in Wikipedia")
    .accessibilityHint("Open Amsterdam location coordinates into Wikipedia app")
  }
}
