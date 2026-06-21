//
//  Wiki_PlacesApp.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 20/06/2026.
//

import SwiftUI

@main
struct Wiki_PlacesApp: App {
  var body: some Scene {
    WindowGroup {
      if isNotTesting {
        PlaceView()
      } else {
        Text("I'm running tests!")
      }
    }
  }

  private var isNotTesting: Bool {
    NSClassFromString("XCTestCase") == nil
  }
}
