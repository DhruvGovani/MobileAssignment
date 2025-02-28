//
//  ContentViewModel.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation
import Combine

class ContentViewModel : ObservableObject {
    
    // Private Properties
    private let apiService = ApiService()
    private var cancellables : Set<AnyCancellable> = .init()
    private var mainDeviceData: [DeviceData] = []
    
    // Published Public Properties
    @Published var searchText: String = ""
    @Published var navigateDetail: DeviceData? = nil
    @Published var deviceData: [DeviceData] = []
    @Published var errorMessage: String? = nil
    
    init(){
        $searchText.sink { newSearchText in
            self.filterItemsBySearch()
        }.store(in: &cancellables)
    }
    
    /// Filters the item by search text
    private func filterItemsBySearch(){
        if searchText.count > 0{
            self.deviceData = self.mainDeviceData.filter({ $0.name.lowercased().contains(self.searchText.lowercased()) })
        } else {
            self.deviceData = self.mainDeviceData
        }
    }
    
    /// Gets the device data from the sever api
    private func getDataFromAPI(){
        apiService.fetchDeviceDetails(completion: { result in
            DispatchQueue.main.async{
                switch result {
                case .success(let deviceData):
                    self.mainDeviceData = deviceData
                    self.filterItemsBySearch()
                case .failure(let failure):
                    print(failure)
                    self.errorMessage = "Failed to get data. Please try again later"
                }
            }
        })
    }
    
    /// Gets the device data from cache or server api based on cache availblity
    func fetchDeviceData(_ refreshCache: Bool = false) {
        if let deviceData = APICacheManager.shared.getDeviceDataCache(), !refreshCache{
            self.mainDeviceData = deviceData
            self.filterItemsBySearch()
        } else {
            errorMessage = nil
            getDataFromAPI()
        }
    }
    
    /// will show the details of device data sent in param
    func navigateToDetail(navigateDetail: DeviceData) {
        self.navigateDetail = navigateDetail
    }
}
