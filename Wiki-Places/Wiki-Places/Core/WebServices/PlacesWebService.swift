//
//  PlacesWebService.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 19/06/2026.
//

import Foundation
import OSLog

protocol PlacesWebServiceInterface {
  @concurrent func fetchPlaces() async -> Result<Dto.LocationResponse, NetworkError>
  @concurrent func searchAndFetchPlacesBy(_ searchTerm: String) async -> Result<Dto.WikipediaSearchResponse, NetworkError>
}

struct PlacesWebService: Factorable {
  var factory: ServiceFactorable
}

// MARK: - PlacesWebServiceInterface
extension PlacesWebService: PlacesWebServiceInterface {
  
  @concurrent func fetchPlaces() async -> Result<Dto.LocationResponse, NetworkError> {
    
    let fileName = "locations.json"
    return await factory.requestHandler.request(
      LocationAPI.fetchPlaces(fileName),
      decoder: JSONDecoder())
  }
  
  @concurrent func searchAndFetchPlacesBy(_ searchTerm: String) async -> Result<Dto.WikipediaSearchResponse, NetworkError> {
    
    let parameters =  ["action": "query",
                       "colimit": "24",
                       "coprop": "type|dim",
                       "format": "json",
                       "generator": "search",
                       "gsrlimit": "24",
                       "gsrsearch": "\(searchTerm) nearcoord:40075000m,0.000,0.000",
                       "pilimit": "24",
                       "piprop": "thumbnail",
                       "pithumbsize": "240",
                       "ppprop": "displaytitle",
                       "prop": "coordinates|pageimages|description|pageprops"]
    
    return await factory.requestHandler.request(
      LocationAPI.searchAndFetchPlaces(parameters),
      decoder: JSONDecoder())
  }
}
