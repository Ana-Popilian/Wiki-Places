//
//  PlacesListView.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 20/06/2026.
//

import SwiftUI

struct PlacesListView: View {

  @Bindable private var viewModel: PlacesListViewModel
  private let didTapLocation: (_ location : Model.Location) -> Void

  init(didTapLocation: @escaping (_: Model.Location) -> Void,
       viewModel: PlacesListViewModel = PlacesListViewModel()) {
    self.didTapLocation = didTapLocation
    self._viewModel = Bindable(viewModel)
  }

  var body: some View {
    VStack {
      if viewModel.isLoading {
        PlacesListLoadingSkeleton(isLoading: viewModel.isLoading)
          .frame(maxHeight: .infinity)
      } else {
        listView
      }
    }
    .task(id: viewModel.searchText, {
      try? await Task.sleep(for: .seconds(1))
      guard !Task.isCancelled else { return }

      await viewModel.searchNewPlaces()
    })
    .task {
      await viewModel.fetchInitialLocationList()
    }
    .background(.mint.opacity(0.2))
    .navigationTitle("Search places")
    .navigationBarTitleDisplayMode(.inline)
    .alert("Fetching data failed", isPresented: $viewModel.isNetworkErrorPresented) {
      Button("OK", role: .cancel) {}
    } message: {
      Text(viewModel.errorMessage)
    }
  }

  var listView: some View {
    ScrollView {
      LazyVStack(spacing: 16) {
        ForEach(viewModel.dataSource, id: \.id) { data in
          PlacesListRow(
            model: data,
            action: { didTapLocation(data.location) }
          )
        }
      }
      .padding(.horizontal, 16)
      .searchable(
        text: $viewModel.searchText,
        isPresented: $viewModel.isSearchPresented,
        prompt: "Where do you want to go?"
      )
    }
  }
}

#Preview {
  NavigationStack {
    PlacesListView(didTapLocation: { _ in })
  }
}
